Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB23A7F70
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557469; cv=pass; b=e9RpjZxUINKxVL5tC63MO8vxwOAypZ1C/RyFwU+UvRT3naXss5hH0RCkcF2jqDdhV6NRAeWiiwvutqqEn87JtIlAAtuAwo20I6di16KUEjViWLh3rZbE/QfkN94HJWR4e9mdYhESvWhdqqfZAUKhodVGbO9+aNS+lrClSTAUDLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557469; c=relaxed/simple;
	bh=fVyaiPhNLlkTRJtGFMUc74d3HCEE4yi+6NDJQOmgi0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p42um+gMqSxGU5i5d4hF83d4rKzRRrB5/g48tM2qASRlRJOWx/+pRvaCHUOldgcCnS1WRw+U7kI+S0IJZOX/7SGk/3N8nDd4Pro/f+OZoXNkxtFQW5O1JYTxjh2zkpAvHzuMjsPW1QlCiN3BCViECZiaVCCs/vUHqV/xhZP+lBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X2MIiNGA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=husQJB9U; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X2MIiNGA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="husQJB9U"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376dwfY2328763
	for <kvm@vger.kernel.org>; Tue, 7 Apr 2026 10:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LHVvsYlB8yFKLNRBW/wwq0r8jj7ohWQtXpAtE7f3oQQ=; b=X2MIiNGAbQ9NY8xK
	F4YJNJZXYglJYcXsQGUSb+vNLx9be7UiA7wKrZEOdTH1a6tXk2wiRQT5rjSgeyHX
	UDJMWbUvbPmkkUmlXXWWGFz5nVMnqudqNGHzCvHaJ1FdVqSDQOLBtnvPTNhQbHAd
	oJCKur+CmSRA1Hr7WE9vvPdJwuEARhgSAeIKBXqrfxDrcg9rAZrz3ZBy3WxKVkW0
	IVDZspMJ3XzwHmWIz67p0ubAOJHorACJgpmSq9IdebStFpldr6UREVSv7WccrzbW
	I2GQ3eL0X3nqiM7qUE4fJOhMNCv2ME2Ug8++sVSIvvpVYkE7qYRspiE/xriLaqIP
	WAOEOw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcms4t8s1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 10:24:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d8ed08aa4so43101831cf.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 03:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775557467; cv=none;
        d=google.com; s=arc-20240605;
        b=iB+ggE/g4mSf41sYugML/Ey9sNuEKKY6HeJZiCEpnTwY1BZ6Ro68ix8SAziVYsRSjO
         +ei9eq4AdxuLsHA8CkSlPSQKN/zx/0x+e1XqBfdxamZeNsdi839kODfxS05DVBW08E1e
         eAMqI0I2IN13ik5aJO1SeSKRTz1v0K+cx5eFJmCgVMo4K9VjKHumvhhwhVLcgftKk0iA
         2k+9DopZylDrJZNO/P2Awt3YBYfewB+wlUeuaEhFF5gzdnp13AlG/TbtxgYFWIgvGBLH
         iX0YFumdzFRcwRNlQYH+MHcxds5gCM/P/9muJgrE9AUWIYEOQ7BI+EDHdF+XHTnduF1H
         pvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LHVvsYlB8yFKLNRBW/wwq0r8jj7ohWQtXpAtE7f3oQQ=;
        fh=YKvyr8oclZk1/3Vts4IqKNedGJVOZOMhzz7kdCxgpRw=;
        b=bBBioB4ZIssN4CPnH6txs+0c7oHLsvLhxy49DePUj18rFAWpLTFc/ncWOIGETgL+Wr
         9OPq4wZhlI0/Tdc3hN33bfMbstN8hxuy9Xf6eNQpinogTfgXNJE2iVOHmxtycR6k7jij
         9a4nMFwSZPl9eNjpcVkiiTMIRm7hirf05qXzUnX+es8lu6ud55qjr/7NCCTay1+xSRjP
         T8WipuTwTTYqNJtJ/XVpd73CsMV/uu+Vbq7hbw1qq8MWrLThrPmKFIzDWHLxcQJFommr
         bLf9WYkiJr0YeffDKBQ0GeDEOih+/6kj/1yCSrvCPbUaZFH6Bp4rU+C4UNNDjhsZ9xMf
         9dDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775557467; x=1776162267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHVvsYlB8yFKLNRBW/wwq0r8jj7ohWQtXpAtE7f3oQQ=;
        b=husQJB9Uzq6FZlgRPtTKRvyeiZ0jfJjG2Wi6REZ5u+MjHJ5VEaCu9V1eNOePtzi8nH
         mBOWA9JMHxbWDaY0nBlg4wpskke2E7jRm547tvIoFfoUe5LLB4lvR307wlKZu0d8L+xe
         c7xuwtAP/i80CAZarlX+FjOiX7dmczMu8j8q8BQJ0dyYq8JC1CuuIHTDA5Ap/LQ+NAAG
         dIiQ17xnL4ilL494PDXpsYkNQy3POBQLgOWecRuKfTEhvqASqdslmzkmqxDrC8lImtDz
         qjMAUSzXk6HcpyrSItdiFnfxZtSN+MBNsH40bs4AbAb19kGS4asmt6s3mK4stJQSfNrP
         07nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775557467; x=1776162267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHVvsYlB8yFKLNRBW/wwq0r8jj7ohWQtXpAtE7f3oQQ=;
        b=fYRyKNAOtO3vsRhqNNIkwaXbc4Cil1YyiPH33yo4EbaCDsxNq6uQFBcprozmim1BO0
         MZKJeVV6lbgSZtuL/rptWF8gPJoD2tfGtBqKPqy4nbF5izg7QQvaRPan+MXz4P/wBbcE
         rz0KlYm4Vr6QsQuxUsdIXvlVzOsIc+XvkTRpVCu2dkMsEiEyaeuhF4tzuvq0U+H2JNPo
         88tkbH0zYDGQ/HAZ/F4kebPs2FFkBUY6yQFLgKygWkK8d2uaBvFG5QSd7hYt0xiYuncx
         Z1ZVYoPinS33UBYZCxqyHlsPk3UET7NpoIP5J02A/EVW/OwRVpGeG1D68tSXciyKiVAL
         p1+A==
X-Forwarded-Encrypted: i=1; AJvYcCXVBPT6VTn+Ef6a90vEpuSUci9P0DZQXq4SdKX564g8dC4NL+a7CSZDIBwaSXortkurT60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvrkfNKJnD1DYEDtB3c5MhNuSczjI5moLRQtPGi4/m5HpiIj7L
	OXuETg6MfedANLDTqaOEry0sxfklkCCMqE4sPeZW18+iDlmyQf5eGLftLEc+KXu9mUY4H9Kv4c/
	CZ1OHe8CBIhxgG+N7aBMisSzK4uiWx0vzkequXHJ7k8oWglfurUmpJRZ0xLsYn4PMsXnzf3xw9t
	nBOVqFhDC7p63zQf3eCQWWDQ7nVsuWNQ==
X-Gm-Gg: AeBDietgSkM1v2riylsLBhQuGNc2veilSkpnscJabXZWoaJmgOgufwnHJwVQawJ8JhR
	gnCZZvMo2cCnD6arORO9L2D47cy2MHTtswdUFXSyZ7guPUHhg6VsYg7nU9Pk6Vnaj4UnaSGLZvJ
	jPnt7It4Q3QPChoE8eCeK0rrwyykN4IZUAiAiygdMWmoOA8z9lXaAzLMnA4c6g5C61a6o81nn/k
	dVuBSU=
X-Received: by 2002:ad4:5d6b:0:b0:89c:8709:d238 with SMTP id 6a1803df08f44-8a7042f7e3dmr251197456d6.40.1775557466711;
        Tue, 07 Apr 2026 03:24:26 -0700 (PDT)
X-Received: by 2002:ad4:5d6b:0:b0:89c:8709:d238 with SMTP id
 6a1803df08f44-8a7042f7e3dmr251197166d6.40.1775557466331; Tue, 07 Apr 2026
 03:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402102953.2984284-1-mayuresh.chitale@oss.qualcomm.com> <adQ7UZVG9rQ1mOTI@google.com>
In-Reply-To: <adQ7UZVG9rQ1mOTI@google.com>
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 15:54:15 +0530
X-Gm-Features: AQROBzArI6PeoNrpcWBNjAlyiYrHyctMnM2KUzuCLf9-tLS7msf1I6SzG_PibWU
Message-ID: <CAHuiULAivSmzwyqDAhSrUUqUMiYmH=UuV9LKz8P9vy5G0xTKjA@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: memslot_perf_test: make host wait timeout configurable
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5NiBTYWx0ZWRfX3UAOrXUv382Z
 LkD4cJzMrlEBVZ96QthUzjVTcw2zVvgduI8OLBHY4nTlhmKfYz8y/ybGXi34vmLDHkqSYHTOecw
 5ubh3/bMM0ZIdJN7GiH6KX0d+QDIdDjVZkkqittFdAwFhkEKSPsjOZebg1tvq9wFtpG/E1UKLoN
 i3ZoMLJ+t8Eyxw0QSGzV0OUtAn3cSEtEuwcIWOK87mJUmOSQnMtOq/KtcSzWtjupMN9/2j2Eylu
 rFRmTGmxHsgonAmnkk+srRatLLlUfXAhKkNTTO4z+MhUw6HAgz8p+MioSvND7NKN3chKeMmSH7N
 mxWCxkp+dBR5xBGZXQohysrMQz/JQF9G2xP6xXLNISRLZnVSv9yaq/AA2NZtF1Y1wuCYmWzsasI
 A9cw6ik/QO2fy7+V0f7phS4pXU8+ciRE28wqjH+pBHLbmseY7gjkKeZiINo8FCYHFEwpls/h7v8
 XqFPM3Oe85An3eYC9Ug==
X-Proofpoint-ORIG-GUID: f-ClNUa5NxEdTWgJpO09HGWsAzEKwO0o
X-Authority-Analysis: v=2.4 cv=WNZPmHsR c=1 sm=1 tr=0 ts=69d4db5b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=1XWaLZrsAAAA:8 a=OZTLbhzomWAjmCbyawoA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: f-ClNUa5NxEdTWgJpO09HGWsAzEKwO0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070096

On Tue, Apr 7, 2026 at 4:31=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Apr 02, 2026, Mayuresh Chitale wrote:
> > When memslot_perf_test is run on qemu, sometimes the RW subtest fails
>
> For posterity, can you elaborate on exactly what "is run on qemu" means?
Sure.
>
> > @@ -900,7 +901,7 @@ static void help(char *name, struct test_args *targ=
s)
> >  {
> >       int ctr;
> >
> > -     pr_info("usage: %s [-h] [-v] [-d] [-s slots] [-f first_test] [-e =
last_test] [-l test_length] [-r run_count]\n",
> > +     pr_info("usage: %s [-h] [-v] [-d] [-s slots] [-f first_test] [-e =
last_test] [-l test_length] [-r run_count] [-a wait_timeout]\n",
> >               name);
> >       pr_info(" -h: print this help screen.\n");
> >       pr_info(" -v: enable verbose mode (not for benchmarking).\n");
> > @@ -916,6 +917,8 @@ static void help(char *name, struct test_args *targ=
s)
> >               targs->seconds);
> >       pr_info(" -r: specify the number of runs per test (currently: %i)=
\n",
> >               targs->runs);
> > +     pr_info(" -a: specify the number of seconds for host wait timeout=
 (currently: %i)\n",
> > +             wait_timeout);
>
> Why '-a'?  '-t' is available, and seems more intuitive for --timeout.
I was thinking 'a' for 'alarm' but 't' is better :).
>
> >       pr_info("\nAvailable tests:\n");
> >       for (ctr =3D 0; ctr < NTESTS; ctr++)
> > @@ -964,7 +967,7 @@ static bool parse_args(int argc, char *argv[],
> >       uint32_t max_mem_slots;
> >       int opt;
> >
> > -     while ((opt =3D getopt(argc, argv, "hvdqs:f:e:l:r:")) !=3D -1) {
> > +     while ((opt =3D getopt(argc, argv, "hvdqs:f:e:l:r:a:")) !=3D -1) =
{
> >               switch (opt) {
> >               case 'h':
> >               default:
> > @@ -1007,6 +1010,9 @@ static bool parse_args(int argc, char *argv[],
> >               case 'r':
> >                       targs->runs =3D atoi_positive("Runs per test", op=
targ);
> >                       break;
> > +             case 'a':
> > +                     wait_timeout =3D atoi_positive("Host wait timeout=
", optarg);
> > +                     break;
> >               }
> >       }
> >
> > --
> > 2.43.0
> >
