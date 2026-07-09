Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA93E16A9
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579579; cv=none; b=aeAOfThOlVQ9OEplkn47fP6WOatZlgHeNfyovPK9fycwOm/9V6SJDG5cTQiZH0ikBu39/emOlMLjyv0yyjQhLdeRY9/MaMHcRwLBDhIfcPBf1qXLr2bhdm/C2ijp9EVYtwWRY/Vsan514tWSYs2WTgvlGsvAq9rZB2QsO+rREn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579579; c=relaxed/simple;
	bh=jWszBecRBvKYImfUA7rp+1CkvV1FXO0NEX8o5vj0/dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfTDIT1IfG5H+2oHX4bHq2lsetPzr9Hw0BgLh1w7YOTufv7uiiRmH/lj2M5qUyZbWt2TPMHw5dPmV4lbnisuZ08FY+YrmMLE0YyTuQRS/FfvVvxyfqtAvT86TGg4iYaQpav07O0RM+utGDjKeVV52if0ZuHT/ZMVpmIOz5uhKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+WaQfXm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f04G3vHD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+WaQfXm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f04G3vHD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783579577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PijaR+i+qGvmTzV/7mms0G50C4ct+YrEuCBRWkaZdrk=;
	b=O+WaQfXmLjNJNblxDvbqWYhCmyTmPNIKSH785DQseu3lybQSJItVHb/UCKdLunTU4eF3yG
	WMtz6qm1kq2J4l4XmxK+0hvtLHuHpRHpE8GDd9t112n8o3UTgv3pgpbWSRAJZjsgCTxa/4
	c8hS6hgMPBG51MCzpk/G4opuCK/5roY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-o71Rk-Q0P7SZ7JqqiYNhSw-1; Thu, 09 Jul 2026 02:46:15 -0400
X-MC-Unique: o71Rk-Q0P7SZ7JqqiYNhSw-1
X-Mimecast-MFC-AGG-ID: o71Rk-Q0P7SZ7JqqiYNhSw_1783579575
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4767036f8faso1191104f8f.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 23:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783579575; x=1784184375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PijaR+i+qGvmTzV/7mms0G50C4ct+YrEuCBRWkaZdrk=;
        b=f04G3vHDw9i2MotO3VVpCUfeUyA2y6HZTgbVP5HOhVJhOsa+cLHyGLodkpr78VPqAZ
         5bXbrq/X/Lra2QIicnnhgn7dmBap+3ubVWlry+wIkxl7UziIO1ql8RTazLYVNp5w47jd
         UgN303XJgZgQCA0Mr0sWv6g07GnfKo0eUmlJo6HNUnn6k0X7Prdv0tDE6KDAnvYr1H81
         002cYoswGM+21gISIyt1LSBT66dpa3ky0Dv7mPFVmAKgTsVR9W+EdKswPez2gSpgrjBR
         dYw9AMxXMnEMevQHZJ5IRxK0nZYv1JGMZiu666SiznzOjdShJkwKNkyXxmuZPOwUOPMm
         bnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783579575; x=1784184375;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PijaR+i+qGvmTzV/7mms0G50C4ct+YrEuCBRWkaZdrk=;
        b=MQ9fQ3CG2ndnYDuqkRHYRMkX8cI5UdO57Qqbz1o5yUBdckLGTC0GByaHPsB/cPCn8h
         SOvwu34CR9WaGW4YQaWb44v0GzZFXCJ0HnMNumSp4gcgnQ4rfTIrO0uaoz8yryClKzZC
         +RioCXjeZwPoNbtHOXbT1F3R92WfMJEzp1BFlwbY22+25Er4htf54JNmb8y/eibN2HOW
         8nln1LgdX1ljXBuyWorGBakuc12XIKfHGxHqoabsiyVURSFBmRh7H3w+1Kgk6NqfWloX
         veHDboVMTSlb7ulB//Oy5Dh2tGmHUvDZWttVGFcnzj3/VYCPaSHegjEdIoJuLUT9ZYGj
         otKA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3VoKa3shiip+/BWRWjqMYukaYgPUVqhTJsgAzeaJZrX2xOAqdxB/Ev24kwI2aDVChsKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQfTkmk2hWLgRVLGt8BX5swemCCgpHqHmIONarXInRYAFPED+
	o4LvmX5Uu17WFWsUFvEr/JVq3g7qbRyM85htYZJFLqVJA19Vq9JKnH/S2H4D+JIttgrjDXoiCpR
	7shOz+xxALKbZhtQ3Ez4WqTPt90bH5BKcUt8uTkUVhuTaLGcj49FFPw==
X-Gm-Gg: AfdE7clVI1nlPVae66FqoQVPIPncWG7N3CV0PoF+JiegMMHjnqJuPrt9iJC88HwVRov
	NwipzmwzYrST6rzQZyp8/qZ+V2tG2GqMoqSj4tw/R1KHwGTO1viSOO1Y01eC5VUxKHiwfHjzbgZ
	aiAvEbSzH1r0KpX6FxIzKK/7cizM+I9U/sgf/YNSJJ7qFjo1NKTkqTh7kqVpZYJd9MfuJqrTpVH
	hOnUz4y5SRk2eMjB/jLSWblLPL86fbzAnzyuisACnMBGifElWePC2wh6HA1apNWF+q65aIwpK2f
	G23oiLM6aVe09m5lGq9bbalSyPW7HdiwZqEwNDr5w4kZXnkUXPe5B9UBwP34tI+FeTPq8ekbH/K
	i6k8SFltA
X-Received: by 2002:a05:6000:4b09:b0:47d:e813:4f6d with SMTP id ffacd0b85a97d-47df07a83e4mr5864630f8f.1.1783579574740;
        Wed, 08 Jul 2026 23:46:14 -0700 (PDT)
X-Received: by 2002:a05:6000:4b09:b0:47d:e813:4f6d with SMTP id ffacd0b85a97d-47df07a83e4mr5864589f8f.1.1783579574340;
        Wed, 08 Jul 2026 23:46:14 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm47603396f8f.36.2026.07.08.23.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 23:46:13 -0700 (PDT)
Message-ID: <bd10e435-de06-4b67-962c-b520a43a8280@redhat.com>
Date: Thu, 9 Jul 2026 08:46:12 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 4/6] powerpc: gitlab CI update
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
 <20260708105122.1177210-5-rathc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260708105122.1177210-5-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2026 12.51, Chinmay Rath wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Adds a few additional tests that are known to work in CI.
> 
> To control overhead, ppc64be is used to test 64k page size, ppc64le is
> used to test 4k page size.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   .gitlab-ci.yml        | 19 ++++++++++++++-----
>   powerpc/unittests.cfg |  9 ++++++++-
>   2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ab1be5f4..b28d1eb5 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -190,18 +190,21 @@ build-ppc64be:
>    - dnf install -y qemu-system-ppc gcc-powerpc64-linux-gnu nmap-ncat
>    - mkdir build
>    - cd build
> - - ../configure --arch=ppc64 --endian=big --cross-prefix=powerpc64-linux-gnu-
> + - ../configure --arch=ppc64 --endian=big --page-size=64k --cross-prefix=powerpc64-linux-gnu-
>    - make -j2
> - - ACCEL=tcg ./run_tests.sh
> + - ACCEL=tcg MAX_SMP=8 ./run_tests.sh
>         atomics
> +      atomics-migration
>         emulator
>         interrupts
>         mmu
> +      pmu
>         rtas-get-time-of-day
>         rtas-get-time-of-day-base
>         rtas-set-time-of-day
>         selftest-migration
>         selftest-migration-skip
> +      selftest-migration-ci
>         selftest-setup
>         sieve
>         smp
> @@ -209,10 +212,12 @@ build-ppc64be:
>         spapr_hcall
>         spapr_vpa
>         sprs
> +      sprs-migration
>         timebase
>         timebase-icount
>         | tee results.txt
> - - if grep -q FAIL results.txt ; then exit 1 ; fi
> + - grep -q PASS results.txt && ! grep -q FAIL results.txt
> +

Remove the superfluous empty line, please. We don't do this in other spots 
between the jobs in this file, so let's stay consistent here, too.

>   
>   build-ppc64le:
>    extends: .intree_template
> @@ -220,16 +225,19 @@ build-ppc64le:
>    - dnf install -y qemu-system-ppc gcc-powerpc64-linux-gnu nmap-ncat
>    - ./configure --arch=ppc64 --endian=little --cross-prefix=powerpc64-linux-gnu-
>    - make -j2
> - - ACCEL=tcg ./run_tests.sh
> + - ACCEL=tcg MAX_SMP=8 ./run_tests.sh
>         atomics
> +      atomics-migration
>         emulator
>         interrupts
>         mmu
> +      pmu
>         rtas-get-time-of-day
>         rtas-get-time-of-day-base
>         rtas-set-time-of-day
>         selftest-migration
>         selftest-migration-skip
> +      selftest-migration-ci
>         selftest-setup
>         sieve
>         smp
> @@ -237,10 +245,11 @@ build-ppc64le:
>         spapr_hcall
>         spapr_vpa
>         sprs
> +      sprs-migration
>         timebase
>         timebase-icount
>         | tee results.txt
> - - if grep -q FAIL results.txt ; then exit 1 ; fi
> + - grep -q PASS results.txt && ! grep -q FAIL results.txt
>   
>   build-riscv32:
>    extends: .outoftree_template
> diff --git a/powerpc/unittests.cfg b/powerpc/unittests.cfg
> index 60c73086..62630ead 100644
> --- a/powerpc/unittests.cfg
> +++ b/powerpc/unittests.cfg
> @@ -24,6 +24,14 @@ file = selftest-migration.elf
>   machine = pseries
>   groups = selftest migration
>   
> +# make a kvm-only version for CI for now
> +# TCG accel support with Qemu and distro release used in gitlab CI needs to checked.
> +[selftest-migration-ci]
> +file = selftest-migration.elf
> +machine = pseries
> +groups = nodefault selftest migration
> +accel = kvm

This does not make sense (or I don't understand it) - gitlab-CI currently 
only runs with TCG for the ppc64 jobs, so adding a separate test for this 
with "accel = kvm" just adds a job there that will always be skipped. What 
should this be good for?

>   [selftest-migration-skip]
>   file = selftest-migration.elf
>   machine = pseries
> @@ -94,7 +102,6 @@ accel = tcg,thread=single
>   
>   [atomics]
>   file = atomics.elf
> -smp = 2
Why are you removing the smp = 2 here? As far as I can see, the atomics test 
uses multiple CPUs, so this looks wrong?

  Thomas

