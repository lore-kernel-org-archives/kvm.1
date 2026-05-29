Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4B3446C3
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063167; cv=none; b=bIzk5MvM3gjt2h3+E6+bcfEGUl2aPdBF0wM36bIuLRplWRiA7yBfvlDTsXqdRW0LKzUh8k8sDanNcEt5d9G/gUW5/3vVN+GAF2115WpO/OeL5Joi3epSf4CQM5SH8QCbvlCkYweo40pq6JpW4D+0IXgzR1w4auG5lPSmhcLfdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063167; c=relaxed/simple;
	bh=9HqZNwsNG1F1vtCVm3KrwBhzoVWHvN278IIZISdmlTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nT0AVbShCUkGG5GMC0ZkOM1Qj0GLW1UpwsLZTrK3Vh7IKxB45CL4BMqh5ookFDbk3ih/GxyFSv2vYw9jYQC+r5yHZpGYqVyIVP5CzVG3ybpaqBGfB/81MC8b4t9FxPpnXbzDlnspxWZ9HACmw/m91CZ3htX8ncMjVLK2tsYhSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+SGP86L; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+SGP86L"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf1dece2ecso11581335ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780063165; x=1780667965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxhLxwcFvH/MI0JZc5MSAm4YaLXkHF02XbmM1toWiqM=;
        b=P+SGP86LAtGuF9KVaoG18G1E61lpaGjJa6fq5OT+7VzFy/yx5iSLFLR7P4r7rehkeV
         NQti62dh70uA/kyHeCt0441CSzVTLhk3pKLtDpmjHY4cdq7czqNxC4vrWLD1gMzk8Tbf
         lTY+U39vG9471sTCtPiF4YT0j8KY+DeMd26x+81jS5FLWvixpVcXB5GTWRXP/lmb6KSw
         zU8O0RCyLV/wYughaBaDh/IZzmvqrY0AbDobxSqLKMbDFoV90m4jGAO16UqPX5Z3HXwI
         h81dw3jkwSlXFUfu3uL5VEWQgrT3j9U7xEeLIdRawSCQ79ynKW/m6rQOcmX5ojcjdeLZ
         NlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780063165; x=1780667965;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KxhLxwcFvH/MI0JZc5MSAm4YaLXkHF02XbmM1toWiqM=;
        b=HrG4oQ6kd+CpVl5qXKDFV1O6EUIMiQNTxWpFR2T5CbKSv5jaEOJS50DplQlxzgJ6WG
         uqY+CxKP+FCPRAE2B0SspvSpCe0xrYR/CV7hK90wbAYpUG+wspenaYMo6k0cBC2CpRGx
         1Tg/FgboCKYX8AjE0I+d4yOblFdeG/srKe1AzVwpHJH9yLgAATGzmCdKn6Avs9n//yes
         Vg0BRDSnHevfY6Xfj3jLLfiFbc3cLFMI+oFGOJgxJV3fxOD7UkOj78J3XftKKVv42gT/
         lBU2ox4H9uHZpd2+SAsT09LR1xqlNgZBTz6dCuMI5dMDCvA8NgJFbC+o8MJe9irez2Nf
         RK9Q==
X-Gm-Message-State: AOJu0YxZn5C3wOFOqsocTM4wLroHOESs+S+VeN5MZRckEbug5C2lkpNg
	XF7t73RyZjXB9bHa6T6D6M/OtGlYbxmdN5D5Tr7WIquGJQ7pTt/5Muin+aZ0oO+Aq/KsqI8B+QG
	aS1Yo0Q==
X-Received: from plho6.prod.google.com ([2002:a17:903:23c6:b0:2bc:bdcd:c51f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da4d:b0:2bf:1cd7:1855
 with SMTP id d9443c01a7336-2bf2099fd54mr37529405ad.20.1780063164851; Fri, 29
 May 2026 06:59:24 -0700 (PDT)
Date: Fri, 29 May 2026 06:59:24 -0700
In-Reply-To: <99613b74-44db-4233-9480-26cc04bc0c7b@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529091714.287963-2-clopez@suse.de> <ahmTjp-95M5IjGxu@google.com>
 <99613b74-44db-4233-9480-26cc04bc0c7b@suse.de>
Message-ID: <ahmbvDGHvORqofrj@google.com>
Subject: Re: [PATCH] KVM: x86: Take PIC lock on KVM_GET_IRQCHIP path
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, stable@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@qumranet.com>, 
	Qing He <qing.he@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026, Carlos L=C3=B3pez wrote:
> On 5/29/26 3:24 PM, Sean Christopherson wrote:
> > On Fri, May 29, 2026, Carlos L=C3=B3pez wrote:
> >> When userspace issues the KVM_SET_IRQCHIP ioctl to set the state of
> >> the PIC, kvm_vm_ioctl_set_irqchip() grabs @kvm->arch.vpic->lock before
> >> updating the state. However, the KVM_GET_IRQCHIP ioctl to retrieve the
> >> same PIC state does not grab such lock, potentially causing torn reads
> >> for userspace.
> >=20
> > Meh, if userspace hasn't fully paused the VM, save/restore is going to =
fail
> > anyways.  Heck, torn reads is probably _better_ than the alternative, b=
ecause
> > at least that might cause visible failure during the restore.  If there=
 are
> > concurrent modifications in-flight, then KVM_GET_IRQCHIP is going to re=
turn
> > stale data (assuming userspace doesn't redo KVM_GET_IRQCHIP), i.e. save=
/restore
> > will effectively corrupt the guest.
>=20
> Right, do you want a v2 to at least prevent userspace from reading a
> torn state? It seems wrong to have this asymmetry with KVM_SET_IRQCHIP
> and other save/restore ioctls (e.g. KVM_{G,S}ET_PIT).

Yeah, please send a v2.  I 100% agree there should be symmetry, which is wh=
y
it's tempting to drop the locks for SET :-)
