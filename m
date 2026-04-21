Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8FA31E85A
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803984; cv=pass; b=GzM2XLMZ9TTfaU1bD/hbA/ZgtbSvCv/pO4WbJ6n/bkf+Jzckip4dqdDwFXfpuNn6hBnhYNldzrdOV0qzH6mg3e+2a2LkQf2EKcopudDM+IRMBvKmAsDxh0WL9GPoBJbOo78OQQUiO31ChHqycNKVxC7+uCLpTVXfB0tsQVnyw8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803984; c=relaxed/simple;
	bh=Hcsh6AK8WDhwu5/ERPiHJpVZFX6B8rC4qpqn3OyuhV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+bxBhFcaFeH9nd5NsjKSjfUID8MRqCJWDJ0KGxB7SCdJHkMY4fufeRDZBNgoaaNzMbx7Xs2J9zKO/keGXwTJi75ttEmijIqh1embE9ShchwWzpdtpRc04IbW+lnLByEgcKZxS9vrJf5RC1a8j2v5OF09kMAlwu42CqGO7JUtyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GThMaaha; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQ0EdqLa; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GThMaaha";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ0EdqLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776803981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hcsh6AK8WDhwu5/ERPiHJpVZFX6B8rC4qpqn3OyuhV4=;
	b=GThMaaha2X9fjKmj2fn0OggGcX+a8PiUEYMf7WlP4rOv/ayVaUVVv5wUbty/pv3/WFfGU7
	FUrHnuzQh/YbMOFTsvDqrrfETQiIJ1eJEgeaACtmTi/srRsA11Q0Gt/i+abp2d6fHK4+da
	Z5YbzY24PapeYbtdWQ9PA14Rt0wBsDU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-OJ9Nvbf6MOejwDvlBfX6mA-1; Tue, 21 Apr 2026 16:39:40 -0400
X-MC-Unique: OJ9Nvbf6MOejwDvlBfX6mA-1
X-Mimecast-MFC-AGG-ID: OJ9Nvbf6MOejwDvlBfX6mA_1776803979
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4362197d1easo3470948f8f.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 13:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776803979; cv=none;
        d=google.com; s=arc-20240605;
        b=KFk5Qa/sQHY/+8GI8y+eY0vYO/V2ZTT2Tz3ue63PjCWNVA8oNrUCveiLU16Psi5Arh
         n4QoXprfZfgTHn0U1F6VPtsF09ae38KGgM4+t3agaXLjfw9u5jRQNrBgKUz7FrQY+2NG
         c+La2gsHir0Kq44nkj0ThEMPjRg4L6ni7v2aV5PrjzHEVKS2lOoGQMGPTdfLOJ8l/Qei
         pylSYjbSVi2NDmljPZ8oiX04iV1GfTX+VLUd+qnc9bnkY5fgotcAWDztflRkwHF59hzd
         eUHTgbvci0MnmcAAOxgzgeU1kEk2VDh7NmonF3Gu2FVEHkTuvqlbIy+N+pJLBBfCM8VA
         1ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Hcsh6AK8WDhwu5/ERPiHJpVZFX6B8rC4qpqn3OyuhV4=;
        fh=gTxTJWmVjk0n6O5D5qzZIcnn1PjLIPWPJvtCHea6l0w=;
        b=IahjCHw48aiHWWME0Ok1rR3ApiPtlXqOkUM0JE03aeTkEX8aqOt7N7m+0a2UTWfYej
         oWzbkuGUtiW6eFafjS/7l/xxbSfrAq/EdBtOh4Q3i3ovAAYEyC6dsnr13yjt5m4w5XOM
         XpHseTBgCxouNZJ0zatBt/SF58EnoJZOqQsR4yVK0pSueSRhdUn8ItU0BTtB47QJWFKj
         DNQ0n9XS4EtA+YPCmpvOCQGFy7h3kTMHBOwO5mvSjqcCvp4q/0X1JFVYutWiLm637TFe
         eb3a+McGmLtNRp2guJETdXRyenOIa42NOjCWfJVjp5VYh7muKZl6LsE/K89vuoBdKQwY
         Xg9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776803979; x=1777408779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hcsh6AK8WDhwu5/ERPiHJpVZFX6B8rC4qpqn3OyuhV4=;
        b=eQ0EdqLaHzdZ/875wJig6b/BfkDuf07j59aiQMlmvdcUuIiqQ5JwveZD/vCK/kE8c5
         MKmnAhVcihC9hRjndcg1cc6wp74itStANL67iuGVCcw6zW1Chv0oLcksXx3H5IW/tLSX
         ksF8CdbMy1JhKYlchrEQoW+gasIOy41JxBYLH8zS/UZ/HPFt9h7p1ZDli+L2djOW7Kz5
         3afWNrvL0aHJ7zybLOUPc3LCrnRXzFSONGc1eozokXVHpyvhYO5+GQugoF+UG3xQ7SgX
         6NAag0q4fhgd1ixX2Zox0fuExi8L8DzAs52m7zd56f1UHMUkuWwiAByWpbc/eWbj5TNx
         2r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803979; x=1777408779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hcsh6AK8WDhwu5/ERPiHJpVZFX6B8rC4qpqn3OyuhV4=;
        b=CQ7r7XcaTdOfdmnljCeL45beyIGOJjkwPh1peELpop8dGo1uDSlEOS/0BchpqT3zSd
         wqNpkoVEUvvMn9Vr5OF30HuOHrOU5AZHD+n5+ldoX8/nSiSfrPIprC4+tFxUCPtYB2Rz
         rys//C/LzMqfu99uuCWvCtbFCkKpm2JsBH2/8T7dwffKJJLejnldAToixDl70AsoJKN3
         4Gsx83u57ZJ/PBxTV5h659bMjQk9yIVxLH8yuxyqmjE5xIF0lih6w65I6ySbdMZZJgZ5
         yiIwJw+57ZQXiWqzL6AWGCCPPYgn+efdgCsmG7KrY+rQ9DTeZ1HB0OBnK7RTQ0RoeQh6
         JZFw==
X-Forwarded-Encrypted: i=1; AFNElJ+Co2w/Mr5P+tbeu/BKkTkOU+V4Oyz/ql4dF6S1yiuTRIjSr19BlQgxMU/3dzGsrcow2vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2uVb3inClcecnpFgDfMWg7x+NWdZ2ctP1anG7OYoxFhBNXna
	i3ZoxvS1L7Y3VnjLrEbKb706CKn4pfkz3jV+YWbwpsIHMtyigyyLox29BKCo8Nua2OFpiwxwvKD
	I5IdjL2J5/UEyjUmZr+hBSjDVLUjL84WCDLYrB71rMjWWfCKkiM92eTJjozXJPzpzqmm06XxfKa
	RUKEDyL+9Oc5KfEcJs7IvX1bvvrylt
X-Gm-Gg: AeBDietbd9Rfn1xK+VkbftJv3Z8ym6Sh7Ohg3oZWCZwFh6proABJ4l0KkS/UqgbRcPn
	VbalxQYDHRDhTeZsUCQENGyKPKJFdTFX52VrfHJ4JuNCaquSkTnx5aRB3Oq92SagQ1JWndmLzdA
	gK/RnfkM/1QDu56e7qIZdkK1ReLn+6CKaGx/Vfp8OXbnGslDsnjuXbM30eCKav4uYlPAbKNS3as
	3lnr0BmumMu+kwwvirSTJfT4YheYo4UP4kEuQ8ZJUz6kptjn3zCKVep7nu+tRmEK1i6EjoKBv5T
	3chY6vcImDT3LQ==
X-Received: by 2002:a05:6000:24c7:b0:43d:740:fb37 with SMTP id ffacd0b85a97d-43fe3dfbe4emr29962880f8f.24.1776803979020;
        Tue, 21 Apr 2026 13:39:39 -0700 (PDT)
X-Received: by 2002:a05:6000:24c7:b0:43d:740:fb37 with SMTP id
 ffacd0b85a97d-43fe3dfbe4emr29962853f8f.24.1776803978547; Tue, 21 Apr 2026
 13:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87mryxekxy.ffs@tglx> <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx> <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx> <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com>
In-Reply-To: <aefIJR_FcEeP-fcS@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Apr 2026 21:39:26 +0100
X-Gm-Features: AQROBzCa1rFm1NtuR6uTb6vv_wBv2TxlajZ8lzEKWEomLP6Wdw47ydH3MgWdG3w
Message-ID: <CABgObfaNaDYCo_rkkwAnFzKYYe9G9wnz1+yiv0H73CbtE8AXpw@mail.gmail.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Jim Mattson <jmattson@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Vishal L Verma <vishal.l.verma@intel.com>, kvm <kvm@vger.kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Il mar 21 apr 2026, 19:55 Sean Christopherson <seanjc@google.com> ha scritto:
>
> > > FWIW, VMX should work just like SVM if we clear VM_EXIT_ACK_INTR_ON_EXIT.
>
> Hell no.
>
> > I know. What's the point of that VM_EXIT_ACK_INTR_ON_EXIT exercise? Is
> > there any performance benefit or is it just used because it's there?
>
> There are performance benefits, and it preserves ordering [...]
> NMIs are unconditionally "acked" on VM-Exit.

Not that I disagree but...

> Even if performance is "fine", changing decades of fundamental KVM behavior is
> terrifying.

... it's not decades, ack on VM exit is actually relatively recent (10
years out 20 :)). The reason why it was introduced is another killer
for the idea, though. Posted interrupts require it, for some reason
only known to Intel.

Thanks,

Paolo

