Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58883C5540
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225602; cv=none; b=ZebBcI7jLLZTM20GpvS6NDbYS2hzrEIIPeticK6uKt5ArSda5pit/8ocDSdnsvs+Q8Bw1OWbB/iCrCgrcdW8N2j8v0zrKWBaMciPgx6l29nC7ScHxo+ZCJyT83zdtxF48jQpVgU0bu8RJBL4jn2fmSctDI17Lla7HJaWNAfNJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225602; c=relaxed/simple;
	bh=AoVPJYFf+5n74QfgpnNarctjZGzLX7v9ebYiOdl4CQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TOtn+QVRwJzP8b0TUYT+vYrbsza26AGlH4bS4ZaihoSf8ZknMV7vs5pgzagaj0MezXDwsYBVOZIacbUeUMJ4GhH0dbNeVguurJ72mpge0Tk8M2YGpaYipJT/BJsd84JckMTHcxbUWsN/SDGg0rAakamADcF7L6g1BO1I4nO9z6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKu51Mhh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKu51Mhh"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6097ca315bso3065312a12.3
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775225600; x=1775830400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=urQBubTNiNENUGbsdH2SnRvWo5FhPgUWq71Q0JWEdUs=;
        b=hKu51Mhhg3YMBHUfq4yqi/wLNj9qvIYvuEFgILXMOq4cEbVdXwBlQhsWvYFR0RJjFy
         Ve5JUx6nhEOn7LAjq1gw344w64SadGz56NZZaIaoSHBlm5Cy38Q66a0zkRlwzx+cAIxN
         Dkl/EHFyZ1SIEPuISWeDjNIfHuqrWc9kpkL8BQ/2qMMKeVMDuaUzicvzEdM1NB/gDF2p
         zPtAiHmQx9XXozdmwdndyuEXJnemjc7xNhqNeClHj7zh92h7OlDRnVbgqDpLLqdNJl8a
         75iFCFrp4O1usdOwowplnanjn64qgnAZb5RsLSeCE8RX27SCmhj661DxiUsFgnf2+RIY
         3jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225600; x=1775830400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urQBubTNiNENUGbsdH2SnRvWo5FhPgUWq71Q0JWEdUs=;
        b=DAE4O826OKYYmkbrQpJxLDgWWLmQF1Vi7GEnIKkOblQsJRpPsspaBZNHMff26MDepU
         a8QsnXp0QkImmKdsMTDF1TuRUsgJEoTx7urTuY3uSszWkWSQBPxoty/yt6nulh1p5LVt
         vVEKuhEZtulbtOoX4vV2b/ypJQFrat6V15XaSCVkpHgUR15TIntlLy8IeH67WZBLLVaz
         z5MdFsuec+P8qcenYVZoskUIlMFrvKRsf5o4jS/GvFQyqS9ydzPpxBRxP+13lh+3vePI
         EEJs78EAhL7ZYJadf655E4FTuSlsc4gb3Tfoyb+va+LX4/FlMKJz1COrSVKtA7wV7BX7
         FNXA==
X-Gm-Message-State: AOJu0Yzo9AbmraW2VXM1Xbf9xtlVUknBIyii3jXfwtYk9WV3C46oseUh
	mNFTVDfoqOV5JCO0vVFXpNuv7aYKuYiFYNo6GDFvO+E+z0+1hX3eWJUB/H8hSaK2cIZtuNjNk3O
	rsm2V9A==
X-Received: from pfbhw14.prod.google.com ([2002:a05:6a00:890e:b0:82a:ff5:27d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1405:b0:824:374a:1407
 with SMTP id d2e1a72fcca58-82d0da44a6amr3152101b3a.16.1775225599933; Fri, 03
 Apr 2026 07:13:19 -0700 (PDT)
Date: Fri, 3 Apr 2026 07:13:18 -0700
In-Reply-To: <bug-221249-28872@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <bug-221249-28872@https.bugzilla.kernel.org/>
Message-ID: <ac_K_v2p5AJJ2up4@google.com>
Subject: Re: [Bug 221249] New: kvm_amd prints "CPU 1 isn't AMD or Hygon" on
 Intel Core Ultra (Arch Linux)
From: Sean Christopherson <seanjc@google.com>
To: bugzilla-daemon@kernel.org
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 16, 2026, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=221249
> 
>             Bug ID: 221249
>            Summary: kvm_amd prints "CPU 1 isn't AMD or Hygon" on Intel
>                     Core Ultra (Arch Linux)
>            Product: Virtualization
>            Version: unspecified
>           Hardware: Intel
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: kvm
>           Assignee: virtualization_kvm@kernel-bugs.osdl.org
>           Reporter: thisisamirv@gmail.com
>         Regression: No
> 
> Created attachment 309692
>   --> https://bugzilla.kernel.org/attachment.cgi?id=309692&action=edit
> log
> 
> I am observing the following kernel message on a Lenovo ThinkPad X9-14 Gen 1
> running Arch Linux on an Intel CPU:
> 
> kvm_amd: CPU 1 isn't AMD or Hygon
> 
> # System information
> 
> Kernel: 6.19.6-arch1-1
> Distribution: Arch Linux

...

>   kvm_amd: CPU 1 isn't AMD or Hygon
> 
> * The system does not have an AMD CPU.
> * It appears the kvm_amd module may be probed or initialized briefly
>   even on Intel systems.

This is highly unlikely to be an upstream kernel bug.  The unwanted probing is
most likely coming from elsewhere.  Given that the out-of-tree VirtualBox driver
loads shortly after the failed kvm_amd.ko load, my guess is that vboxdrv is the
culprit. 

[    3.087169] kvm_amd: CPU 1 isn't AMD or Hygon
[    3.118021] vboxdrv: module uses symbol (cr4_read_shadow) from namespace module:kvm,kvm-amd,kvm-intel, but does not import it.
[    3.118032] vboxdrv: module uses symbol (__flush_tlb_all) from namespace module:kvm,kvm-amd,kvm-intel, but does not import it.
[    3.118063] vboxdrv: module uses symbol (cr4_update_irqsoff) from namespace module:kvm,kvm-amd,kvm-intel, but does not import it.
[    3.124334] vboxdrv: Found 8 processor cores/threads
[    3.152502] rtR0InitNative: g_pLnxInitMm=000000000ba3e8e7
[    3.181635] vboxdrv: Found KVM hardware-virtualization symbols
[    3.181638] vboxdrv: TSC mode is Invariant, tentative frequency 3302385743 Hz
[    3.181641] vboxdrv: Successfully loaded version 7.2.6 r172322 (interface 0x00340002)

FWIW, attempting to load kvm_{amd,intel}.ko on the "wrong" CPU is benign other
than the error message.
