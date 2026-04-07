Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD663A6B90
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557279; cv=pass; b=KYdMVsPKBa3uvRRXE7tERl4QjgxXp7XTkm0VZdVZ4y+2MxQ61fdm9nRDjHPyFvN6/TtmUhMuz42vlA148eBVkbYNiEEI6Br4YRyNQsXb1u4oEBylOTcl3TCPj5+rd2AWhuV+bFbtMNg2QCwmmf1jla1UdDrqergquwKqCpKVSn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557279; c=relaxed/simple;
	bh=I4b2KJgsDgGll33udp3PExX5zTeYtVJMIJBKEnalk04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUPoTJSKXh33dShcq0jhePtytfi+Z/2xYgeUlpc9Bbbks7NygJOb0iTjcDeq9j/06Pb89Okv+oSsh+z2EQyBQWD7tlkb1GkJo72uMxdXZmps08p204WkvxQFtkL7hmw1kDUDRsBgYOkf+/sai3r+8eQHksCZl85boHGgRt5ku9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DjmGiyx9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tc9MxsuV; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DjmGiyx9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tc9MxsuV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376q7tc3536836
	for <kvm@vger.kernel.org>; Tue, 7 Apr 2026 10:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I4b2KJgsDgGll33udp3PExX5zTeYtVJMIJBKEnalk04=; b=DjmGiyx9DU9o8RuH
	SvJoZyKsv5yR0UYhodzaMZHJBKVr9TOFdRU9XOPcH5POtrSYx86jVNXsu/slM/BQ
	qHKU+T9CDseaVts8aXipHFq6/jmMYbo4VjiVpDYyTLrLWOR7l8ICvnmvCO7TOCpl
	s5vDPTcYZRKo7wppsgNL2tNmJicsIWhxXz6kvocuFubcqjdA6tEDQ+BfQMUNZpJH
	eeN3l8doZguTnobCMYqpulOKvqQkkF3juhZv47ENIjfKsnRo4hLrq1gp8ssdybv6
	QAOgVZFPs8kTTc9lJwyV5g6KoQn8LSA5S+p0+Y7So1LZojdTx3+yzAl8fjH9uDtj
	Dlx84A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra28xp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 10:21:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89fa878662bso47225336d6.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 03:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775557277; cv=none;
        d=google.com; s=arc-20240605;
        b=HQc4dxVZnsJdQqL74XZ1/6wsVpN34zFP/p7VNieeci4mbhFHEncsVb1kzMPv+6c+Bd
         DGWJR62qtDsKhrT91SMARmxggJwt7vrxa+hCdaX4t6wrHwZP7AS8XbLyRY+oPiXy9fuf
         rgKVfn5m8OSXvM7YHBCYTSllebQdJCbFGYDgMCHzxGVAlQb828oaKQFjvHoI+eFG/pGf
         3Cs+nTKjErn3g4AUUKz0pAC0j3NhFetDP1G1ZgZtQu24by98ZdKYci80nZAt7jGAIDJ6
         r/iF0UqH2pYcb4uWKPyqSyXSKqJ66d3H28ZNRIJsQDYR+odMhz3eGMz9wXojfTIE7yaT
         Giow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I4b2KJgsDgGll33udp3PExX5zTeYtVJMIJBKEnalk04=;
        fh=K7HmkM/mKzm526/++gvkEuemuaOx85kP2InsfPwax74=;
        b=M4vm6mHCbav8zTbbZc2MRE85sHEz6QPaPkgum2T+z7x417FW07o41Z1bI051A5uhDb
         wNsgNN2Dr6Nx26OPSNw646WWNyYCNwUEjRwJ9803Vos2V5AHTGGU6SLRvo+Fzi/iHvWO
         L29xQE1TnoqiNRCpmdhvvJQLPBy34vLjyaLivms0cTNkgOzVGg/Pqw3068A3FzBJ3SEE
         0wodi6FtDTRuFW4nzSJEoltXpVNQgqx2VKkV9tdwd+J1uAMeME1f0EM2arI6ObCbVEMU
         hslUY5dDT3hOtH4XA4zcdWfyOjaa4omzPWH5Io+6h+4/QXqzXh4XLtEif1LZzr2uHvR+
         DUPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775557277; x=1776162077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4b2KJgsDgGll33udp3PExX5zTeYtVJMIJBKEnalk04=;
        b=Tc9MxsuVuEg1xSvL/Mr0NrIVp18YufJ59+Kk2diZftNQ0WlNVdBgMhwHHwM4qB+DX3
         e5CCnaAfmiba9pAF347TVtQw+IMo9cYPjMTLPKmKd3aFkGdudhgmnCdyqDT4sTUxSt7V
         9pnPWyqqcFFBf38pmsrvSr1i37Csq0jSzfebag/bW9xyC/NhQHZABwUdYqLOrIUY9toI
         8PxG5lTaF/1G+YQzQQDB22Lms0Qh+noT+8UT3lpehQGxIirA5iNBSl4V1tuVgCzY4RRI
         mn4Osu5GE7GgkEJR+U5cwLsy9X8H8qVCJ0KRtQwe6bx6q5ycgPv4K1PTpW1Kw4ggHfdS
         n1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775557277; x=1776162077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I4b2KJgsDgGll33udp3PExX5zTeYtVJMIJBKEnalk04=;
        b=IfFnRdmAc62MTSitoNSERa/fkwi0JljmtsAmBNDbS4B0x6VJEiC8Ggn54OY/ucQ0Vg
         U3qauJJL236woDuZT0zrWL15CtQWe82MpM06J/092HJHQbTWBFz2GbnSqwFYaWjKZxD1
         Ms1jH/Pc1xTtRQxsyxxFmpOYTxsOKTFvwjp688Gz3AGW+4bdHj+0OYsA7fSyvWFUHVN7
         9a08kE+96Ck0PAEaHLgDjW0rrXAQVsJr2EW9yUsw9Y0fQkJSoQE7uHxgJerlpHTFs7Xb
         iuU2bOzhFq2WUkXsUBPeY/ESaxcmqoUwWLlcdIxukT62//Mncwp037+sgYNE5k/dV82E
         RJFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXvJGzgESUUiCFJkkfbZpqk/qpUYNZUlmVUij5FqVeklMY1r1gb4006t3Gjq0tcGUKKAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmfl+Epan3aGcjUKRySeYYbuc87BzS/sM/OOMTQysTlhcmjbz
	cXpYH7+o2e8XxXMzaEgGA2Yw0wtCN4oPAMw/oGzX41Sds689KlHbc9nr2ZSytPaE3kDQeBzEOEq
	kAkYMDMmrxTjZEgc+WyQJ6xq9RAQaxAkEqmIVaF0hb+hh5O31+3tsuLDg7PYEnedBET+H48rFb1
	Nj6ysMIyvuQxiFG5FL0ACBrqUJVS5MKQ==
X-Gm-Gg: AeBDieskysllQVGCxMHzLn4opmstY8DUvcoGdjs2oU8Q+89xBdhjvzQtAB1VpsRmxKH
	g6jw2WdJlIrrfzmJR4Y/IDQBHvYJLEI4g7rEjTSyv74mID01pHTNHly8d7M9uo3GjNEwCTZmVOH
	OEn+RtABUmxrbYPhTEqt9dFB5iZtBNQCLjEyiC57mN/laiIGZhuiOtXODaFeNY+VfFNB7ch73I1
	Hungf4=
X-Received: by 2002:a05:6214:2aae:b0:89a:14be:4593 with SMTP id 6a1803df08f44-8a703d214f8mr270573076d6.35.1775557277129;
        Tue, 07 Apr 2026 03:21:17 -0700 (PDT)
X-Received: by 2002:a05:6214:2aae:b0:89a:14be:4593 with SMTP id
 6a1803df08f44-8a703d214f8mr270572536d6.35.1775557276699; Tue, 07 Apr 2026
 03:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402102953.2984284-1-mayuresh.chitale@oss.qualcomm.com>
 <64d44f37-7d31-46be-b9ed-cc86969777dd@maciej.szmigiero.name> <adQ6_MyjhnpJYJ5H@google.com>
In-Reply-To: <adQ6_MyjhnpJYJ5H@google.com>
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 15:51:04 +0530
X-Gm-Features: AQROBzBc3NsMNpcx9CW-oR8ilWQ1jtDsR_uRyyJ9VQlCxouo5qJCi3l9Y34FMHg
Message-ID: <CAHuiULCkHojN1QEb7OSL0rozL_wYpw1Xts1pVcThFcDaQg3zqw@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: memslot_perf_test: make host wait timeout configurable
To: Sean Christopherson <seanjc@google.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: nwzUEFm-5KDKOjOYUzJOuCclJod_I2Ql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5NiBTYWx0ZWRfX25ZKlhmYU1Hb
 CC7Hu9R7YOtHMklGt+XqxYAArXgcI2g4k7zuvTT8IyIXqidZEPzq87XtzKK3t2Z3nWnOlPoEmHj
 2WZqSoi+sx0s9KnAcHMFu7Ope8vV5mo8gxTW+pIrIbZeb09646XNpO3j/NE8j83ssVONzP0OE85
 tlfGScXCPDew3CMzNr81eJjj0VGQR9zTM6pORO2zHtemiUSlc0SK+XuaK/cISo6mXtyRqc6sXPH
 U3YzTf2HVGeEPC4yl/+UQR43Q7KAaoNZ1BaTBoZWJKnC1QMMtaO0OpoCSE/cGeWFwnm+1nC7S1i
 fz403zPEG166F46vvN77YTFHGa8IpAdw+kb2IWXiu9w5pkjwTxSnqsmQ8gFeX8Ed7BwF7JzO2t1
 RdOriaNPIZZJh0vTTk6tTcSiINWXPojgi7BsuRaHv1VzneJ6AFjOGHjcnQdATImBuNsE9Bm7OTH
 Af9gdWElSnTpbxCHAzw==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d4da9e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8
 a=bGZ-ABlMOwxLtTgv92gA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: nwzUEFm-5KDKOjOYUzJOuCclJod_I2Ql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070096

On Tue, Apr 7, 2026 at 4:30=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Apr 02, 2026, Maciej S. Szmigiero wrote:
> > On 2.04.2026 12:29, Mayuresh Chitale wrote:
> > > When memslot_perf_test is run on qemu, sometimes the RW subtest fails
> > > due to sigalarm, indicating that the guest sync did not finish within
> > > the expected duration of 10 seconds. Since the current timeout value =
is
> > > itself a bump up from the original 2s, making the host timeout value
> > > configurable via a new command line parameter. Now the test can be
> > > invoked with '-a' argument to run the test with a suitable host timeo=
ut
> > > value.
> > >
> > > Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> > > ---
> >
> > Out of curiosity: which KVM-enabled setup takes more than 10 seconds
> > to run that RW test?
>
> Hmm, I assume "run on qemu" means running in a VM that's fully emulated b=
y QEMU?
> That would probably explain why it's so slow?

Yes. thats correct. I can update the commit message to reflect that.
>
> > Does it have like, multiple levels of nesting?
> >
> > When I wrote that test I calibrated it on a mid-range x86 machine,
> > where one iteration took on the order of 0.01 s.
> >
> > 10 s time limit per iteration is already three orders of magnitude
> > slower than that.
> >
> > Otherwise, the patch looks sensible to me.
> >
> > Thanks,
> > Maciej
> >
