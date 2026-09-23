Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C78497B77
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181979; cv=none; b=mFrFOyPJHEjEO8uK2CNyjD1vOYmsFGsztk+a7NwyLflocB5ZjBQbQVwksnQL0bpM+LYWzdc1YafKcN7cZFOYyHLXxzD2qj+iGf4sK1cA5jVWh+LItjj1aEnpi9ZosGzgErpv1DjN5AJLC8yFuQyq3vifZHFXybcpwmsaMYhhpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181979; c=relaxed/simple;
	bh=+6YtGWh1GB/8dEEZlOqT0sJubGXXQsFmMIsmDOO4Cuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ow6AbwRnHxmdMgNLrEt9772EQO0DoQ6X4SLqKTMO6C+dMEuizdYue6ITLw6q76iBMJ9g15at0BkxdI22w2b+3HU+KWotrftsc229KPuVLy+r3o/sz3P7LTAxuK0S9ePK5XccqdoEZAvKOFPpNJBaCrTC+z/Eu5BUJcwDumHMuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBqauWLZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gMkBzb0V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBqauWLZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gMkBzb0V"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGTZ31595326
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/uIU5X5vebpwZqZqXeVNPWhTKkvilxlk1lz9DCq44h4=; b=pBqauWLZhNX9pcqJ
	u6FaFnfvmXoaSvWfRganR8/ZV1tNVAtcPh8buWqRioJ41K59h4EaDQiyGeIEAZSA
	0JT1yNPz5pfFX2HWbf0RPS/4R+B6j5mmEtnsfekrOfK3ookqABVwdheOYNCWFjst
	Epxky5BtOQfqaMmIzrCspzrC5nu/B406pZdKihqQwUdZlYayFromT9oCnf8LAL6g
	meXebbpT/HiyfmmRtni27KYcDOTyGo9eApQYAM7+Nc9tJz3L7HNkchoyZQXPz8Nm
	+AvtctUgw1T+kmGHI3cCJhZeVuBztxJeVxPkFumjJ7ZBDZKuI75hETNMPp47vFY+
	Crt2FA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxry3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:46:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so1436027a91.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 09:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790181973; x=1790786773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/uIU5X5vebpwZqZqXeVNPWhTKkvilxlk1lz9DCq44h4=;
        b=gMkBzb0V5uoiUga0texRFmfIiBRBY2qAaSIA/n/SrOB3GyadrAY7QXgS3QgzjWRSiW
         7rgyYk3nf1hoMDKYVJf+zIKGFBVba8yqGIomsgNjKOShqi5UeLl6xf1Gp1t7qBFEGSv0
         XZ/d6HdVaLTto06zvL3DDywJ/OB4Qzl+7FEaQvXEJN42W24STXElqxiMCbcc43LzFCsG
         20WyMybMemIkQuNMUtHtOKh24tVcRUp4BSA12sFaxC0lPkwE/yJgfYPsoeJzJkM6YCci
         uLQKbAauAya9nQRwzn51q3EzMqMudo17xTIeJLf4tEf3T/jsiahe2OYXTANwGpI/7SmY
         W3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181973; x=1790786773;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/uIU5X5vebpwZqZqXeVNPWhTKkvilxlk1lz9DCq44h4=;
        b=FzzETm1c8O9i+o/DjD5qZR7UTLCNOk4/Dm6K5mMpPoLToEk2130tT2Ig7dOpJ3U4n8
         924EK0v/tSoXG5attt5gy6luatHaP+9877JEswilK9+eFPEFml+a1FPIvCR1cFqq4Ek6
         R9A2iHAR/eSC7p1groAm2qyoI/gwesR0n3GAHFwAtAnoH/GCgJcvNYAybRPYxSqzzSag
         RUv/U0U0Hyyo3gYxyG29ETjxIWyJVyaORQwLvhbXhT1rl6Wh5F9Y5EcqKxKF8D7kBf6F
         NLAZR861ht9D8gTGMQGJCaYGLT/hiEQoCfrLbRgsfW7cY3B2nJ2v6fLiXhaneAFSL+Du
         nAYQ==
X-Gm-Message-State: AFuF++l4bpGacCUhwtt5fTlzcNZjNxCYKpKbNwW5nhoZnIN5byMmUmWf
	hkLlHvF2e5d83tqM8CoZhP2c35smUqjq68ZsHR7LNKcxt9QCtCvb5N2A0aKGyQ7YWEGAhgCBtwY
	0ZLZa1+aMtCffRVoxFUTEzx2baEwvuU6yBD12MUEEFPnDYfimRiNyJVs=
X-Gm-Gg: AYBFou1hXhz1xrEcPL2tcuRrlMOOhUoU7x6KJ/Uauv9ub4nTHHUgH4xR+0Us5dVmW6Q
	O8LTpu0bKu2vjLSwfHwYoIrkI1BPG1RlmZdnBXlrjLm5OuEYB8DVWPy//SwUaubUGojSxPu8qRt
	TWVtqjTIi868xlM+4X8ku/EJofPtEKnHJvzecHbiTDz/EhtpKVGnqgaaZWAzL9DDpeLmuQ3bPmn
	3mmZH2h7GAtclDLchhYPj+JH/Mpd7HCTQipqQX9j+fDMusx9xB0OcvFbnjIaHIFhc9VVyK4dtz+
	yxV7zRn6SxTirHBO2rX5fwbFLnbZrGQ4wiP0MKp5W6Z+U7mqyO4UhsUIavmspx+PygpU02R5vs5
	smGdgl5e4wUu6o8iBxxRjhmlrMr23tKS+OBvQJ3/euFJzaWOMeLFLug==
X-Received: by 2002:a17:90b:5747:b0:3a0:2ac2:6ca2 with SMTP id 98e67ed59e1d1-3a07e5ea208mr2939160a91.31.1790181972741;
        Wed, 23 Sep 2026 09:46:12 -0700 (PDT)
X-Received: by 2002:a17:90b:5747:b0:3a0:2ac2:6ca2 with SMTP id 98e67ed59e1d1-3a07e5ea208mr2939132a91.31.1790181972102;
        Wed, 23 Sep 2026 09:46:12 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07ddf23desm5867334a91.10.2026.09.23.09.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:46:11 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:46:06 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
Subject: Re: [PATCH v18 6/7] firmware: arm_rmm: Ensure the RMM has GPT
 entries for memory
Message-ID: <20260923094606.00003c6b@oss.qualcomm.com>
In-Reply-To: <2164b046-bbbb-4cfb-b797-5df27fbe313f@arm.com>
References: <20260912083611.2513845-1-suzuki.poulose@arm.com>
	<20260912083611.2513845-7-suzuki.poulose@arm.com>
	<178978126543.2352296.12214136703168879825.b4-review@b4>
	<65b0c03b-36b9-4e60-aa55-c3b4b85e21ee@arm.com>
	<93aea89c-0a05-4b5a-905d-2e8c14a9e894@arm.com>
	<20260921145838.00003b04@oss.qualcomm.com>
	<2164b046-bbbb-4cfb-b797-5df27fbe313f@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 4nF1xTzvWnEj594tu0fQc5NFd3CNgIqw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2NiBTYWx0ZWRfX6g0CftrSHaUU
 TvG1Hlr1moT+VaKdahHBMoecQjmUDfJfID7exIVzxmUxegSNOAY+kw/pxObjc1LyqCYIaiWacC8
 U0wo6/N7i+85KX69yOecD5aX7g9cWMUP/EoefBNYaWJgrzMaoq+cUls8/AhTlGryaFrpyPCedN2
 F/Sy+TUAdqkseS2/+Bv0gSG7UEEpFZh5dDXBAq1KuzA9/A7lLO4yNTrEoUJgGfQbx5Rh6/5GHCE
 Xtw70Lhubk/M4UvXHF0UNJecLaaWMwK2KMeQtMi47+bxqDt5VBkdfGYoKOmn9K7Ru/y4PSELsYR
 K7L4GAqXZ0d1dkxoRRIfYQfQdudLl5GH1LrqYEClv5H0UMCo1rQw498yZCB1jXX/gQ4w25KNSAj
 eL+27znR8t/UaNXfJGOrukHvoVjILEZRL6uP4oTJjllhsAui7IIVBxOwS6K5HofXcYype8HMmMt
 552Z4xqaTpmnK5EE85A==
X-Proofpoint-GUID: 4nF1xTzvWnEj594tu0fQc5NFd3CNgIqw
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab40255 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=0e8ahwmGRF4KwER_06MA:9 a=wPNLvfGTeEIA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2NiBTYWx0ZWRfX4MzVPugohNgZ
 WZ4c6Zg++SHLnjK6t7zOo2Zwt4JdFuFrhklZ5qG+LkKHFrqBt+U9zjZ35DUO66taodYVwhP5cVK
 Ut/KN+acSUCPVZbuCTNKfUENqsOsB30=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230066

On Tue, 22 Sep 2026 23:55:52 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> On 21/09/2026 22:58, Jonathan Cameron wrote:
> >  =20
> >>>>>  =A0 static int __init arm64_init_rmi(void)
> >>>>>  =A0 {
> >>>>>  =A0=A0=A0=A0=A0 int ret;
> >>>>> @@ -786,8 +970,24 @@ static int __init arm64_init_rmi(void)
> >>>>>  =A0=A0=A0=A0=A0 if (ret) {
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("RMM activate failed\n");
> >>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D ret < 0 ? ret : -ENXIO;
> >>>>> +=A0=A0=A0=A0=A0=A0=A0 return ret; =20
> >>>>
> >>>> Why did this change? =20
> >>>
> >>> Rebase messed up. I will restore it. =20
> >>
> >> Actually this is not. We dont have to check the metadata if
> >> we couldn't activate the RMM. Also, the failure path at the
> >> bottom has "deactivate", which again is not needed. So
> >> it is the right thing to do. =20
> >=20
> > Only after this patch? Not from the previous patch?
> >  =20
> >> =20
> >>>     =20
> >>>>    =20
> >>>>>  =A0=A0=A0=A0=A0 }
> >>>>> +=A0=A0=A0 ret =3D rmi_init_metadata();
> >>>>> +=A0=A0=A0 if (ret) =20
> >>>>
> >>>> And this is hitting another bit of guidance in cleanup.h.
> >>>> Functions shouldn't be mixing __free and friends with
> >>>> gotos.=A0 Again, not a bug here but there are large ugly
> >>>> monsters around this stuff, hence the blanket guidance.
> >>>> I haven't thought that hard on how you avoid it here, but
> >>>> usually it's a combination of suitable helpers and wrappers
> >>>> and resulting code is often more readable as a result. =20
> >>
> >> I could change the hunk to something like, but that looks ugly.
> >>
> >> @@ -1010,20 +1010,12 @@ static int __init arm64_init_rmi(void)
> >>                   return ret;
> >>           }
> >>
> >> -       ret =3D rmi_init_metadata();
> >> -       if (ret)
> >> -               goto out_deactivate;
> >> +       if (!rmi_init_metadata() &&
> >> !register_memory_notifier(&rmi_memory_nb)) {
> >> +               arm64_rmi_is_available =3D true;
> >> +               pr_info("RMI configured\n");
> >> +               return 0;
> >> +       }
> >>
> >> -       ret =3D register_memory_notifier(&rmi_memory_nb);
> >> -       if (ret)
> >> -               goto out_deactivate;
> >> -
> >> -       arm64_rmi_is_available =3D true;
> >> -       pr_info("RMI configured\n");
> >> -
> >> -       return 0;
> >> -
> >> -out_deactivate:
> >>           WARN_ON(rmi_sro_memxfer_cmd(sro, GFP_KERNEL,
> >> SMC_RMI_RMM_DEACTIVATE));
> >>           return ret;
> >>    }
> >>
> >>
> >> Either ways, we have to cleanup the object on return, no matter
> >> the route we take. So the original form is much more readable
> >> for me. =20
> >=20
> > Agree to more readable, but that fragility of mixing __free() and
> > goto is a real problem that has tripped many folk up - hence
> > the perhaps overly strict guidance.  Rather than avoiding the goto, I'd=
 just
> > not use __free()  - go old school and have two labels for errors
> > and an extra manual free in the good path.
> >=20
> > 	pr_info("RMI configured\n:);
> > 	kfree(sro);
> >=20
> > 	return 0;
> >=20
> > out_deactivate:
> > 	WARN_ON(rmi_sro_memxfer_cmd(sro, GFP_KERNEL, SMC_RMI_RMM_DEACTIVATE));
> > out_free_sro:
> > 	kfree(sro);
> > 	return ret;
> > }
> >=20
> > Sometime the new toys aren't the right answer. =20
>=20
> I have the following hunk on top of this patch, that could do the trick.
>=20
> diff --git a/drivers/firmware/arm_rmm/rmi.c b/drivers/firmware/arm_rmm/rm=
i.c
> index bcdbed26cf08d..4385f49068965 100644
> --- a/drivers/firmware/arm_rmm/rmi.c
> +++ b/drivers/firmware/arm_rmm/rmi.c
> @@ -1033,20 +1033,19 @@ static int __init arm64_init_rmi(void)
>                  return ret;
>          }
>=20
> -       ret =3D rmi_init_metadata();
> -       if (ret)
> -               goto out_deactivate;
> -
> -       ret =3D register_memory_notifier(&rmi_memory_nb);
> -       if (ret)
> -               goto out_deactivate;
> -
> -       arm64_rmi_is_available =3D true;
> -       pr_info("RMI configured\n");
> -
> -       return 0;
> -
> -out_deactivate:
> +       do {
> +               ret =3D rmi_init_metadata();
> +               if (ret)
> +                       break;
> +               ret =3D register_memory_notifier(&rmi_memory_nb);
> +               if (ret)
> +                       break;
> +               arm64_rmi_is_available =3D true;
> +               pr_info("RMI configured\n");
> +               return 0;
> +       } while (0);
> +
> +       /* De-activate the RMM and reclaim any donated memory */
>          WARN_ON(rmi_sro_memxfer_cmd(sro, GFP_KERNEL,=20
> SMC_RMI_RMM_DEACTIVATE));
>          return ret;

I'd just use gotos or an actual help function.  But your code to=20
look after long term - so up to you :)

>=20
> Cheers
> Suzuki
>=20
> >=20
> > Jonathan
> >=20
> >=20
> >=20
> >  =20
> >>
> >> Cheers
> >> Suzuki
> >> =20
> >>>>    =20
> >>>
> >>> I will see if I can improve it.
> >>>
> >>> Cheers
> >>> Suzuki
> >>>     =20
> >> =20
> >  =20
>=20

