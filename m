Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE47409E0A
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110707; cv=none; b=PQHdkJc4scG2l8I9p0fPDTQdT8JMpFIEX0zF5pj7EOtpFbITSYA5LLgb26hM9uAfSw6zNHZg5EtXzCVKS6ERg+je6ckQ+1ngR0FWg4R2o93RhkoJCtYAdITaddxHZIUe91A1OYJcff2tpJqJ3H3KVAOM7MMZGRWCEfLLDil9sDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110707; c=relaxed/simple;
	bh=15kGEfFVsaFyV+gfji9GsmDE9bOsQwCOCiKS+Yn2TCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ud+Q/ZjQXnx38sfobUUFhrK33TkP82uemUMGg2V6HLXOu5ElQoQUm/OifxQA5Cab3Vozed8LbXScQU0DHfx2yDC+yJhviY3wLyYMlqKrEPV0TmQpsIqdXuf5tLLpyCNzRYEVJ5DeorfqztLtQoKQEyM9yz0Bx3ekIUyWzY5pJ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbPxy656; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbPxy656"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36641fe4aedso4700723a91.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779110705; x=1779715505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8qoVNkOwHjXFecSlVoxGZKKrJQ+Chvyfnc0mBlOZlI=;
        b=JbPxy656senXZ583044ZwZ/8hnxWVB+iAv3Qi9cvEbcaK7vyWAOGPIdRrCIMuXIvzB
         eL01AEfhE2tb2yLu7zjimzlfln38QUwy1H2Nfr48JGo5udlat8zyI8ZioPz03lQhDQnD
         lE/gyhNhtCW3CGCrM/Mlmzu6XDj5j8E5aJw+fiackJzMgdlqLeAgRTqJHghC8Wc1LJTo
         do5IAJiGiw6VdiMLXNESF7Vo/G4hinG02Ey2PL3dC8Stx/3YBS8jgkAy+j3KmWscAQ64
         vIO4I6V1Q9J3F7hb93RiRxA7Yb4j2+5abrXuoC6BcSb8uAjSSFlPuIAp6UUne28ffPoM
         fjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110705; x=1779715505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8qoVNkOwHjXFecSlVoxGZKKrJQ+Chvyfnc0mBlOZlI=;
        b=nI2Bs23rxo2+yG6tsUi1QENiPuZ4dho1r47O4b8vES3Fv5iaTNC9sYfT5mGG56ljhy
         Cnlw8R1sl0Ghi3l1/CNKt4C4mE3CotuKm/MBeabUTdc0Q+r8yB0F5m6jHxQhKvID81o6
         V4Wq33t9EHHjyigObmlJn3uWwhMsCFlhmC7DIsoSyiraHAlRM1+buEnhX1nS4xeSE90j
         ZjXLgJaHSGcEcP5eADaD3p5t1rjXPAR5iwGyovwae8QChHidgt2G9dwgdrUfEBsCfKRv
         D5mdMCpLvk3b9tWF1I0oBkN5Os1UPP5i0g6tpKExLGjLBill4Z6YqhCzLT2/6+UX0J04
         GzMA==
X-Forwarded-Encrypted: i=1; AFNElJ/AOXBlAeof9NFwN7aHD0sHlmfmfSarLvuziqMsdt7vIv/dQNCRJt5BOLXfuueMFDN6r60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/bju2KmONPP7jSzZZmAgxuF31HRjEGAQj5Dj9Cw8rKh//AR3
	EmRJYWxpfld5wccPE+qWB09Nci/fY78RaRW2Lud5W0dwrODo+jN6UwX/CHBJsKPFMM9MlP451Uf
	D//iCsw==
X-Received: from pgbbw2.prod.google.com ([2002:a05:6a02:482:b0:c80:24e3:5130])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:c14d:10b0:3b2:698b:cf4
 with SMTP id adf61e73a8af0-3b2698b0d27mr6157278637.44.1779110705325; Mon, 18
 May 2026 06:25:05 -0700 (PDT)
Date: Mon, 18 May 2026 06:25:03 -0700
In-Reply-To: <22e32ff9-3d79-4130-a3cb-3a4ec2efd498@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn>
 <202605111130.64BBUXDN013040@mse-fl2.zte.com.cn> <agO_0ejKd0x38_-E@google.com>
 <f64029bf-1f4c-40a7-860a-eb04fbe5317b@163.com> <agck1WqW-TyEqkqd@google.com> <22e32ff9-3d79-4130-a3cb-3a4ec2efd498@163.com>
Message-ID: <agsTL_viyxDjamX9@google.com>
Subject: Re: [PATCH 1/3] KVM: selftests: Add unit to dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Wu Fei <atwufei@163.com>
Cc: wu.fei9@sanechips.com.cn, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, anup@brainfault.org, 
	atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, pbonzini@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 18, 2026, Wu Fei wrote:
> On 5/15/26 21:51, Sean Christopherson wrote:
> > On Wed, May 13, 2026, Wu Fei wrote:
> > > On 5/13/26 08:03, Sean Christopherson wrote:
> > > > On Mon, May 11, 2026, wu.fei9@sanechips.com.cn wrote:
> > > > > 
> > > > > Unit is introduced to replace the default 1ms if specified in command
> > > > > line. The following test can't trigger failure on my riscv vm:
> > > > 
> > > > Failure of what?  And does the failure really not reproduce with a higher interval?
> > > 
> > > On riscv, it fails to write protect some pages with valid page table entry
> > > then loses track of dirty pages. Higher interval doesn't help because only
> > > the first usleep matters, after the first collect_dirty_pages, all dirty
> > > pages are tracked precisely then there is no such problem.
> > 
> > Ah, gotcha.  Rather than let (and force) the user to provide a larger sleep time,
> > what if we instead randomize the delay before the initial reaping of the dirty
> > bitmap/ring?  That should provide a good balance between coverage, complexity and
> > user-friendliness.
> 
> I'm fine with your solution, I applied it and it did trigger the same issue.

Awesome!  I'll post a patch today.
