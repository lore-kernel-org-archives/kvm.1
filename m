Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FEF4D6C59
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573890; cv=pass; b=Pv+k8YaRvEw03X4N+nwdufhzheHCgpfDNSAyu4J0GOELGhUDHkdNa9NDWRUyFlpRoWaevyAvgHrzLHI1IGROrDD62jOkDynkVhYfrqR06U5z7bM7dDyl7U79fKGhXeXV1roPTwrmi2WFSYuGM0I2ubIfosxOaD6LQFW+xaLy1yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573890; c=relaxed/simple;
	bh=bo+nR5vgnm+LSKdCiwZsyqB138gI9BLV55OIiNb16sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeKKqw9QhRLtCIFD6dvT1AUhpa1v+cajUOFzoNtkc9XLxPcUDcGzumJLv0dBfT9YnM+GnEBogIhN8N4k8gQyUOSpEMleAR7PKMsGZkFz1hru8Z5RdIWeAEvLul5lpxr/b58M4IEZwtR8O+nmQdMt8POvOY5FBOtvqq6KdyeigIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGLcz3J6; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGLcz3J6"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910c9ff1cso91715385a.3
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 08:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789573887; cv=none;
        d=google.com; s=arc-20260327;
        b=L2o75AwYsJ3dMfNJocGPfSolDiXZkGy/JLHPdOdLItzBIHlb/K1t/gS8O9yY41zjw+
         +nr1APuXjmyLgQBuUYEb6suN3Q7s9QTIEoGuRYKLRuIc1PCBuSzIJ+Z8Qo7w9nX5FpuV
         TQMmiWF68/KgQ8vm/WisJmpvqmVzDxTn+5obExNaPkltBno93jLasUfBjdQHQdAOwxc1
         us1zkrtkC8YUpqPHeol9ehqPhT7G1aa5cchRESHs39L3pt7tbdSFBuYu2tFaRfaJIQtN
         04igkxgQvz701/34bQOT3exXnTHOUMvZC805p6fr98SnqGgwb/U32NXWd3fl3lRODIKd
         USHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1DZZDmRFFus61Ri0IMvmk4ynsdfBpq9f2UmqLYuX2d8=;
        fh=tKq+NGS0C60ag/Rd2zbkkzhLpDlCFxwP3r6aptAIrtk=;
        b=W9Dclh0nxgekvYEo/dPYzjhvlQtYcjbaahgdgihtfYJjl+HbZQGEyXhxMSmosyGaoa
         8gn66FAypyKLUBG87Bkj9FlVILhCicMRXcKGk6jo76mkau002BrmTLJIgjgJrAyJ3GYo
         cRgAGvVZRDjDAXRtbgBuExql1XH4WX4TaJyhpThU3gbj7NzF1KNu7h08aHWnAOr/fisn
         LpcY6Ypwrof7aBYkIXf5qh6uRWiOsTQxOAWemSMRveIL3k+uHvZTUP8QDtC3BbN/1x+A
         BDvLpxtBfHrgRkA9CNhb5y3fHcF6Bba0qGc6F6k4ntNn7U1xoSP54tnkCmhavg4DEqpc
         te3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789573887; x=1790178687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1DZZDmRFFus61Ri0IMvmk4ynsdfBpq9f2UmqLYuX2d8=;
        b=AGLcz3J6D8cp2rGznRsPFyPcIvINU1v/yg7T48xqnGt5dkha28eLx3ZfmOg1Su4v+i
         /gU/fpKa6rhN0owZ4/z7QDHBl+dedwCtQ8/XevU3H9AHT8xYD526w8nZWwY+2u6tgSn+
         ECGKKVv8XmSgeHCWNtcxogjK0+ftF4vWAK5bmZ16DQfFDw4LBTQwNd1OauDstAgUzGwe
         /ii8ms4kdiMyTe5T94twxodV7yW7QFT+ihV66946r04t8j6+vO06ssdSlbh0i1CBBHrm
         BL54/wxrNbgksxPZNnheUgK6K1QcnXXGIMDgDvva+4M0BWNy/4lnjgNU9xDcGxEuDm2a
         VDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573887; x=1790178687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1DZZDmRFFus61Ri0IMvmk4ynsdfBpq9f2UmqLYuX2d8=;
        b=HW1TmJJwnKizy0FZycbyoT+IuV0u86WRrhBTf/5DpWKus/bmTgoTaKJ1b1CqDhNM6K
         1KmgMCwMHJssgU4RLsFf9eR7+rv5KWssdV4oED+nI7IwJ2wZj4n/SEzyUXtvk0O7D0sO
         zGiR+VeumxgsA8d7Pm7bRPF5GGfd4ALpPGq9+M0+WRptWwJt87jK9qnpbjsL0WwsVEHk
         17QLWaK49/K1upo28zSrp2VAInxwxteeKNRFnjBdokTMHjCd542NRvPyEjI2bWsyzxO4
         7V+l5TjlOc7trlnfsXfDxNTujBx+WXQFseSwy1cNsX26DzXchdrkgCWpvKbNFVasrqfq
         m3Pw==
X-Gm-Message-State: AFuF++nLNbgSLskZISlyhuK0o2cM7RQSD0sGiDMCjOoqVKYJTf8u2Yjp
	ZppmA6B2RP21etqIq8Q3M8dtV0OSWVhXN4eK4ObdrmVTQlKYALMyTvmzZsbTGpaVxW9Lov7h7Iw
	zC1eqbkjtYl+7grg3mkoCqVMqPbKcJA0=
X-Gm-Gg: AYBFou28mRr+z4d8lHEi1PHmBevlXwJplE2jRiCMR6dA5st1EhMT6OCygsRdFx2fHul
	WkYjeYGbJXJG4fOmA7D5GyT5a3WsqWANE3FapOxQh9rPfLrMENzJNWe5nsevYv5ZakilS6bzSgO
	9BpddwEbv3U7OQyzVX0Z62+dHbvb/W2KMMLNl1wmubB4Kvazfan8TSo7esme+tlalbhmwcHIbN2
	RYumAV6NweA1n6CAGj/4Qhd4Ip8YuGWe5ghQeYCbh/sqbeVB28HqF6IILpJagSf98nwBCi0WbNA
	EyLclxCZc6jNeB1IsM1siplgXngACfNPJPfm9xldv/yFxfjJlc8C/busVqQC3iSqSIwU157p0pK
	LLzS+xFNjOxMJODsDvC65USao7H5LHRPCkJQ+UFJFL1ttrA==
X-Received: by 2002:a05:620a:2b41:b0:93a:463:1296 with SMTP id
 af79cd13be357-93bb77012a6mr512342585a.18.1789573887002; Wed, 16 Sep 2026
 08:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914155301.14499-1-tharitt97@gmail.com> <20260914161000.E3CD21F000FF@smtp.kernel.org>
In-Reply-To: <20260914161000.E3CD21F000FF@smtp.kernel.org>
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
Date: Wed, 16 Sep 2026 22:51:14 +0700
X-Gm-Features: AcwNN1XHwQyBqLjDeQ7jaI6DM6CbzWrYOn3V2n8CNvXZZDMWJ0_m1PdaYmObsWE
Message-ID: <CACak8wMDhXTXkS6PAMCY1_SbvGK_v6YQBCZxBLJZY382JuKbiw@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Test partial KVM_CLEAR_DIRTY_LOG requests
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	me@brighamcampbell.com, jkoolstra@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +/* Use the 2nd 64-page range to exercise a non-zero offset. */
> > +#define TEST_CLEAR_LOG_FIRST_PAGE    64
> > +#define TEST_CLEAR_LOG_NUM_PAGES     64
> > +#define TEST_CLEAR_LOG_BIT           1
> > +#define TEST_CLEAR_LOG_PAGE          (TEST_CLEAR_LOG_FIRST_PAGE + \
> > +                                      TEST_CLEAR_LOG_BIT)
> > +static void guest_code_clear_log(void)
> > +{
> > +     u64 addr =3D guest_test_virt_mem + TEST_CLEAR_LOG_PAGE * host_pag=
e_size;
> > +
> > +     while (true) {
> > +             vcpu_arch_put_guest(*(u64 *)addr, 1);
>
> [Severity: Medium]
> Will this result in an out-of-bounds guest memory access on architectures=
 where
> the host page size is larger than the guest page size?

Agreed.
The allocation is sized in guest pages, but the clear request and
guest write offset are expressed in host pages.
I'll fix this in v2 by starting with 3*64=3D192 host pages and
converting that count to guest pages before applying the allocation
adjustment.

> > +     kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
> > +     for (page =3D 0; page < host_num_pages; page++)
> > +             TEST_ASSERT(test_bit_le(page, bmap),
> > +                         "Page %lu should be dirty after INITIALLY_SET=
", page);
>
> [Severity: Medium]
> Does this assertion assume that KVM_DIRTY_LOG_INITIALLY_SET is always sup=
ported
> if KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 is present?
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914155301.14=
499-1-tharitt97@gmail.com?part=3D1

Agreed.
I'll check for the KVM_DIRTY_LOG_INITIALLY_SET at the start of the
test, and skip the test if it is unavailable.
