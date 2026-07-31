Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85587442FAA
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518881; cv=none; b=ifM6S1evyjWyWoI622TKLS2bhWRrgUY9Fs3zIl+a2ox9Bn/Vmviok3DdO8VH6gz3P2ipriHHJhneQqoROaNtB07jG4JJkRV+2oLNcR9lDr2qLxVxPzsRLHJKxL/O1djxKCokLp5p1BeTxWA8We9dQ4i2lcC44tIYYYINOyAZ8OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518881; c=relaxed/simple;
	bh=UDpYe2Tx4XuD5LemyWw//zY5kwL1leOW5OSpqdrWcSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RF29IhLPkH4sMZgiz0u5oJ7AhblGnlxO+oCnprmiKg5i1xef12fTRGbEsGA/BRhn03J/7UIpXGZYX30Bm1IQTx81Q75JWG5ZpCEBUQ5AYd4CwsITE3BMMyTc9f36xrjr/NMsp8im1ylNhonVjGRg/WWdN0j08jp5RHjdqKduZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CiNfNpR8; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiNfNpR8"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2caf4173b1cso22475435ad.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785518880; x=1786123680; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIfuZJWx97IVmiAcI0nYTV5I0RoblwpbhFeaam0U4M4=;
        b=CiNfNpR83eZIbC+xLw55SD4Dvn1raUpq5tj3S+nBOrH0k8X6oHraGx92hJ9R5ERqLw
         gDRJUWazgGPhN5iCwq2v1X94X636RKhshpcRoUqEVyx0wS6ZfDdlg/8Qrxznh0KBWbj3
         APq/EyqGwDuK3YG6cVDMPkeRH+v+mwQEKEgSjAH4T7xAae3glTTIQ22kjOh7zzBVNPi2
         T6a/qmy6y5L0KqR86w2Q9FlYFDRRLuiRUl15P5A4p5gDQW0r0tgwgyfmz8tKtaprd//U
         /2lt7A0gNzuqDXCfjaWLEAgRfgXvMXq0VzFw3Owo9Bd9QZamtRsYiCnTmEE3CAcwg8qs
         myKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518880; x=1786123680;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jIfuZJWx97IVmiAcI0nYTV5I0RoblwpbhFeaam0U4M4=;
        b=akWDuXr7Myo8glaSpjf337bAO+CNMvtbErEjJtNMCW/lmwN8Fn6I7NVHbW5xjYVTUH
         XKlngEq7hinpyCiZwJoUfWco6tRwa5N3ca6Gaj3hrwkkWDrRMCcioGDJxJtMIZL3t1cV
         vgmgQmTsaEUbq1MVW/w6FQSWZUm9uvfI/m7DPAyCBARJsuKFuhaKyQCmu+7uXl5yVXc5
         rZc63Vo64+8vNtc8n1f6i8N/JnDNQuZRThg/n6SMEdftP95fzN/GmAXgCFhCsCT5zoCt
         pO/huG6JnxKy2aAoIvQs3AyjXObgNnoXzOeOBEBo/YG4Hbe9p8A9eWtOzRN7H016aCEF
         zUjg==
X-Forwarded-Encrypted: i=1; AHgh+Rrl6p4pZCNG7hKSFZADP48t6RRDbOnxgIkAe+x/FisGCng2V7cerRSl1HbowLyAEevSLQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWdLoGaF5GvBC+qsXbqtOCBikcuioloFHROipN1cKUgKEVBPa
	1on1Pb7MviF/LcaQb2O83G2Lyz+aSKVgmXEcCz8DTI5evMlijyhxGh5y3Z8jexafjXl6QlVIgIv
	jmoooFA==
X-Received: from pgbq32.prod.google.com ([2002:a63:5c20:0:b0:cbb:c1a9:51f8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:50a:b0:3c3:75ff:95b6
 with SMTP id adf61e73a8af0-3c92a748fd1mr582286637.31.1785518879545; Fri, 31
 Jul 2026 10:27:59 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:27:58 -0700
In-Reply-To: <20260731171540.7B3FF1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731170619.2620845-1-seanjc@google.com> <20260731170619.2620845-7-seanjc@google.com>
 <20260731171540.7B3FF1F00AC4@smtp.kernel.org>
Message-ID: <amzbHqvWFk5-HpQY@google.com>
Subject: Re: [PATCH v2 06/12] KVM: selftests: Affine threads to random CPUs in
 hardware disable test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 31, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Randomly selected CPUs are not removed from `allowed_cpu_set`, leading to duplicate selections and artificially reduced test concurrency.
> --
> 
> --- Patch [6]: [PATCH v2 06/12] KVM: selftests: Affine threads to random CPUs in hardware disable test ---
> commit 093b65b96e15e7cdd5b611bd7d8556fb88cae6e6
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: selftests: Affine threads to random CPUs in hardware disable test
> 
> This patch modifies the hardware disable test to affine worker threads
> to random CPUs instead of hardcoding them to CPUs 0-3. It also honors
> the starting CPU set during this process.
> 
> > diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
> > index d8288147b0a69..bd23c13003707 100644
> > --- a/tools/testing/selftests/kvm/hardware_disable_test.c
> > +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> > @@ -149,12 +149,15 @@ void wait_for_child_setup(pid_t pid)
> >  
> >  int main(int argc, char **argv)
> >  {
> > +	cpu_set_t allowed_cpu_set;
> >  	u32 i;
> >  	int s, r;
> >  	pid_t pid;
> >  
> > -	for (i = 0; i < VCPU_NUM; i++)
> > -		CPU_SET(i, &threads_cpu_set);
> > +	kvm_sched_getaffinity(0, sizeof(cpu_set_t), &allowed_cpu_set);
> > +
> > +	for (i = 0; i < VCPU_NUM && CPU_COUNT(&allowed_cpu_set); i++)
> > +		CPU_SET(kvm_pick_random_cpu(&allowed_cpu_set), &threads_cpu_set);
> 
> [Severity: Medium]
> Since kvm_pick_random_cpu() doesn't clear the selected CPU from
> allowed_cpu_set, can the same CPU be selected multiple times here?

/facepalm

Remembered to CPU_CLR() the selected cpu in all my fancy version, then forgot to
do so for the simple version.
