package com.osahub.hcs.vaccinate.services.dataaccess;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyFactory;
import com.googlecode.objectify.ObjectifyService;
import com.osahub.hcs.vaccinate.dao.locator.VaccinationCenter;
import com.osahub.hcs.vaccinate.dao.registration.AccessControl;
import com.osahub.hcs.vaccinate.dao.registration.Child;
import com.osahub.hcs.vaccinate.dao.registration.Person;
import com.osahub.hcs.vaccinate.dao.user.AppointmentDao;
import com.osahub.hcs.vaccinate.dao.user.CallRecordDao;
import com.osahub.hcs.vaccinate.dao.user.YoutubeBroadcast;
import com.osahub.hcs.vaccinate.dao.user.YoutubeBroadcastChannelQueries;
import com.osahub.hcs.vaccinate.dao.vaccibot.AnswersRepository;
import com.osahub.hcs.vaccinate.dao.vaccibot.KnowledgeRepository;
import com.osahub.hcs.vaccinate.dao.vaccibot.VaccineRepository;
import com.osahub.hcs.vaccinate.dao.vaccibot.Vocabulary;


public class OfyService {
    static {
        factory().register(AnswersRepository.class);
        factory().register(KnowledgeRepository.class);
        factory().register(VaccineRepository.class);
        factory().register(Vocabulary.class);
        factory().register(Person.class);
        factory().register(Child.class);
        factory().register(YoutubeBroadcast.class);
        factory().register(YoutubeBroadcastChannelQueries.class);
        factory().register(VaccinationCenter.class);
        factory().register(AppointmentDao.class);
        factory().register(CallRecordDao.class);
        factory().register(AccessControl.class);
    }

    public static Objectify ofy() {
        return ObjectifyService.ofy();
    }

    public static ObjectifyFactory factory() {
        return ObjectifyService.factory();
    }
}