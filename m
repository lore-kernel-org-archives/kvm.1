Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F322DA75C
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948476; cv=none; b=UuTuL+jF4nsmYD/MsdnmDzvc1g7+mCd6HgJQkm/vrWbOkE46UUILrxPx4RdBCHplRKhjPO6quarvw1CsyoRiLMguqqUoI9u6IoDPNZumAX66UWOGc5sdjY9fVa/zsx6ilGJ9Nf9Pv2vEndOOjl7rczYysNvo6LZVbdCfHgac4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948476; c=relaxed/simple;
	bh=Kjq4Pg1RnSNshQ/oIm/A1+YWWa+4x8HogwZlKAKfb3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pOl1nhp+ZiuV+w/A5QYtqWRXt6DJ8kWZHOnFlim0TOe68jSzX5Xnll8u5WTKfzB0JGU1dcpeEnT/3lph6XDx98Wfy5jBc+nX9MA67H1f2fxhwdMRxKEYh3iRCvtSIRoLFpnfereAygrClhylkqbiS7WoKRFK9wxfNQuNB9VqAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T6oEVirx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6oEVirx"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-848693daa20so2003577b3a.3
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783948474; x=1784553274; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6Enmvxk2RO2BuqLZjH3U2On0bHXYN40a1K8A0vvkYc=;
        b=T6oEVirxrb+uHgd3JtlRQVd2uMvP0qUNsNIYjic6EYtF8N9PDBmb7w/2JvNylVzfyS
         f+y1uCeEC0IXP62EHLAm+44Mj1dyPinqIhyW3uBG9KN7iNwyz3t/YrdIY+asNrLhx+U1
         YGumc6o2/64QGKKOQz+/tZFy2Y+bRwzF8Do/LxdcZW82o4EpZP7ENOADhiQXxpemoIhp
         B2I61GR9dnxQkw6wevSdofn4qhKGIFJz7hQ8x7uIhtEZ+kRiuo053TnnN58xG3Cc94j6
         2xBR2aMPB1mLk4hqNA/QSIZbfQSYwn/kI6AbCpvjcm99u2a+QoJJ6/j9FZUpMAzBJ91N
         XPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948474; x=1784553274;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k6Enmvxk2RO2BuqLZjH3U2On0bHXYN40a1K8A0vvkYc=;
        b=kMsmPr6qUZ2L7NcBsA1uOzoZ5FMDTBB1k+Dhi+27eykXgWDddt0PC8+TNYC4lsWL/C
         Fjx0d5b2rn9ciE805BKhQ+7Iuw3mmF3TeKJgSDl2RfFAJvMkQvHA7TV175SOu2Ym4KbE
         7ug8/DUQCJMI/wdqrghyq0yld6NXiL/WQQkFVcouT1KT8i+oUp3G+Jxl47wMTJIeVqoA
         X1O/MrqQqYbFqYaTCGLGDu47F2nbQaeS6BhIDTcwkgjuGrFr+UjNOUaL612IRcTeTbOE
         dqp4URWnfb7q2LVcrFxLv2zMFZxDksUJXb5V2S1SXixmsSgqC63d7e6j5OSG91MzCQDx
         lqZg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0v/yFeoUyHYAMM1zOoi7VsM4amJrJtqN1OzxTiQssdl+qm+iDtgC59nzynj+cEN3v9qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV8D85AyPxN984NvSvYDWKWRId7lxIrU53T91ozaeDvvZmDCk1
	y5OgRvPIEE270ZVXXbmf4OgJtgB7G3i1vO5jQpzGG2grob09sPW7gpzuzgiiNVX9thSsdDZ09kf
	1Rtp1EQ==
X-Received: from pfbfo1.prod.google.com ([2002:a05:6a00:6001:b0:848:2c15:fb05])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d9e:b0:847:8650:69cd
 with SMTP id d2e1a72fcca58-84889664234mr8350251b3a.33.1783948473850; Mon, 13
 Jul 2026 06:14:33 -0700 (PDT)
Date: Mon, 13 Jul 2026 06:14:31 -0700
In-Reply-To: <20260712090039.36038-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260712090039.36038-1-kartikey406@gmail.com>
Message-ID: <alTktxR0hGS2gKS7@google.com>
Subject: Re: [PATCH] KVM: x86: Handle -1 return from kvm_cpu_get_interrupt
From: Sean Christopherson <seanjc@google.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9dcd0a11dc9703a49511@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Jul 12, 2026, Deepanshu Kartikey wrote:
> kvm_check_and_inject_events() checks for a pending PIC
> interrupt using kvm_cpu_has_injectable_intr() and then
> fetches it using kvm_cpu_get_interrupt(). These two
> operations are not atomic with respect to vpic->output.
> 
> Between the check and fetch, another thread running on
> a different CPU can call kvm_pic_read_irq() which sets
> output=0 before taking pic_lock(), making it immediately
> visible to all other threads:
> 
>   Thread A: kvm_cpu_has_injectable_intr() reads output=1
>   Thread B: kvm_pic_read_irq() sets output=0 before lock
>   Thread A: kvm_cpu_get_interrupt() reads output=0
>   Thread A: returns -1, WARN_ON_ONCE fires
> 
> The -1 return is a valid result indicating another thread
> already consumed the interrupt between the check and fetch.
> Replace WARN_ON_ONCE with a graceful goto out to handle
> this race condition correctly.
> 
> Reported-by: syzbot+9dcd0a11dc9703a49511@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=9dcd0a11dc9703a49511

Already being handled, thanks!

https://lore.kernel.org/all/86078441-92eb-4461-b823-7d3539ac5859@mail.kernel.org
