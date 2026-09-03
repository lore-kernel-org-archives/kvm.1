Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732AC4E80D1
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450879; cv=none; b=W49dvNw6N1UXQ5Xf2ss67iRw4qZMLlIH+XPQkoV39vI4OdoK+c85sFqb2i6f5Y9ulf/Js3L22k/Lj5oUG4UIi+ztLOIjLrorGlHznmyT9zhQMbOTRbKe1cRzb8VevBwLXD9a2l98I8OmNbYtughaxxI+Q0MbxTDIT4uAH4sD2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450879; c=relaxed/simple;
	bh=Kk2AD3UOwPSnwmgTVWy6P/2K5EFdMfMyACv+LM8k68Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M81C3tbdQvjzhkFhRvppvrYZp9jfvRgVa5/evCAXD9AtFespe5ryh1m+5kVZ9wy09JCXO8XwfmuJ/1MrtTHrcOwgsbUz/82IuXdKZNPFnFZzDCb/CCP+Bhc5Bp21gkvBUQESyDAbcTKLdlFWouIO0ZZs3/2eYauiHFyYeIqs1Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=orQHUJsF; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orQHUJsF"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa4e4684bso58471025ad.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788450878; x=1789055678; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mGifk9h8LIddg9L9JpNR126tGysvi+0g41edfZ4g+M=;
        b=orQHUJsFfJFwE/Er9oXA+g8Cq4LzA9jiSBhLUrxndI8d+df5PPzDJ9Q9lQ1p+Jid6l
         uyPv+Fnv7/V9P/hT/ucg0jVefOoZe/PIedqpR7UpEzqobb+Rt+eAYoQAXeEYJy8zJobV
         DulMuDG7twFIn4tpRFKXBMQ5CVsGPqklTTjha7DZGuqYmRN4xCIjHPNZYJ4zCu+axsPK
         hYRxjCjm6yN+Fa9MxcoqY3xt/WtRLp6ob2u7Shg2UKjLgnUIj9GxssknS7b2Qpl7joCv
         mQgWHvEKHUFpzWFQQheg9fl5za+ggQVGCV+Q5laT5NVyXcnPm/hWEHZiMdK2NF5ypJEh
         ehzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450878; x=1789055678;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8mGifk9h8LIddg9L9JpNR126tGysvi+0g41edfZ4g+M=;
        b=l1DfKx+x75HS1NBIq+OzvDwxWC+xb+OXPjY627UbZl9c5gQljqcCDMVqY98ela+DaD
         RJcLF8zYEtNzToglwdH5tb0c+/ni6Ix4jylQr0LE0Aw/ydF2OImyrgEw06myabyMnYXc
         vA9Uk6MPr/1ykGc3AilGhDhgVbC53B2t75+87Kj5Y4Y9GZ39WtjwZkQxOrZVgOJKrllx
         UhZYOL2rD0rS3GaBQDM5r7QHN+nkBXNNHq8jQseOyF9J67RttoEyY5Ws1nU9r8nN90Uw
         5zD4ob2kBFu+JjyPBiRJQDUBYWCvI3HTuWXZdK5/0fVsAalZPf2DgDIz+8Dbd6YLBEny
         O1AQ==
X-Forwarded-Encrypted: i=1; AKwUvBztj9Dq57Y5kDYMh3I2+SKJCM5OBzV33VPwgdsJtfXK28jgULIn0o0Ij4cQJ0JjSqFAPtc=@vger.kernel.org
X-Gm-Message-State: AFuF++kVb2gtathyYCTRIF1HPhoBDl1Nmwc+JbiqDJJM/Q18SzKVF9DV
	UAiGqwLcYEj1lf95116QKSBhaPF7BGiILp1YIoAaairT/RqBTY8C2umDvwKGFGi621BYGwBhOk3
	NEB3AQg==
X-Received: from pgp23-n2.prod.google.com ([2002:a05:6a02:62d7:20b0:cb2:563f:d136])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7d02:b0:3d3:ae50:97cb
 with SMTP id adf61e73a8af0-3da35f9b1e3mr1317921637.24.1788450877399; Thu, 03
 Sep 2026 08:54:37 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:54:36 -0700
In-Reply-To: <19d4feb1-d703-4c62-8622-a6d5e9d6394c@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-3-seiden@linux.ibm.com>
 <apdweRfqt4dTxcU9@google.com> <20260902075028.231001-D-seiden@linux.ibm.com>
 <aphLXQL1H2zYZgTi@google.com> <20260903114241.33034-C-seiden@linux.ibm.com>
 <apmEi1NmOUvmUBFP@google.com> <apmFClPZ2WcDINmT@google.com>
 <apmIGgMEN8w-kQAm@google.com> <19d4feb1-d703-4c62-8622-a6d5e9d6394c@redhat.com>
Message-ID: <apmYPMMPCNzK9ZEA@google.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 03, 2026, Paolo Bonzini wrote:
> On 9/3/26 16:45, Sean Christopherson wrote:
> > > > Actually, thinking about this more, what I've proposed here, plus the pattern of
> > > > #define-ing macros in arch-specific kvm_host.h files, should suffice.  For things
> > > > like __KVM_HAVE_ARCH_VM_FREE, it absolutely makes sense to #define the macro in
> > > > kvm_host.h since it's very directly tied to an arch callback.  Whereas with KVM_MIO
> > > > and KVM_ASYNC_PF, because they enable compilation of C files, it makes sense to
> > > > define them in Makefiles.
> Ugh, defining CONFIG symbols in Makefiles sucks.

Sure, but IMO wrapping entire files in an #ifdef that comes from an arch header
sucks more.  And technically, these aren't CONFIG symbols.

> I don't want KVM to be the. one that does things differently *once more*.

Too late :-D

arch/arm64/kvm/hyp/nvhe/Makefile:ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS -D__DISABLE_TRACE_MMIO__
arch/arm64/kvm/hyp/vhe/Makefile:ccflags-y := -D__KVM_VHE_HYPERVISOR__

And I think there's value in deliberately being different, because CONFIGs are
kernel-wide things, whereas the thingies in question are KVM-local macros.  I.e.
IMO, having the behavior stand out is a good thing.

> I'd prefer to stub out the contents of the .c files instead.
