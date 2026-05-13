Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E9421EE2
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676523; cv=none; b=EyoOrY2MSsmmuECq6c9nel0Xr1MKqtvG4ejYtqE0xJtfNVM9XSrRoiQSTyrhPqLS6N9x2OlZDNlPeBRNBpojOQk5Onl5CMS6ybU9W+GnJ4oLJTd8KXDbs1j3W2/FF3S73DGPaxqwNOq9QaqBE7Dhv5EAkOALxi6FUX5UP+5vPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676523; c=relaxed/simple;
	bh=mmyRi+Zx/6q2gDvD/t17nESFmxjkc5pSHHo05OFL0dA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N0qf4CqBXhyC5zV+aeBrq108JwsHfcSLH9jJhJxu5kJD9/SgbyGTROWmorwWWLLc0hakLghtSP1XERDNQToHDjyHfyssoXR+IByP8w7TG/zHU3psTNpzN+937nM/1S3gaFTsZFDuJl8M+Wy1wEekE1EP93LfJ+5Nfm/4HP4rI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2yL7q9J; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2yL7q9J"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bce224720d8so3814061a12.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778676522; x=1779281322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MK1gTGxtPYOlCCins8M0QHXqM2NhJUagixEFgmK4yWM=;
        b=S2yL7q9Jkl5OGMjP6y3HQBI7BiJmFeZgbnHXuw76QgyYzfgc6cllHznt5Nw7W7pS2C
         +q39Iskjzi5yKrGRSQzBXrjV1xGW+xhVI6SyHpFYMIf+ir+jqcS/S/lgM+0/LDSkAaRc
         mkCHISXHbkidKDSPZXHeMyr0mpacjJVId/xnSMGEK3HpU7MSwcwtlA4gAsTET/qiNEQv
         TyhhqroCKKhMJOdhPiJj83lOXo2QYQaHSUMyRtRIYiCl/Jhf7FLiHINwnsTBFntFRoNZ
         BW1ShZXwEe61Yb75w37imODFhoebYE7dSQsLCcAQM+sJ75AdDW0b9cpFdvNadKdcThb8
         13NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676522; x=1779281322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MK1gTGxtPYOlCCins8M0QHXqM2NhJUagixEFgmK4yWM=;
        b=BSHys+UYJTuvBKf5AeRffoSSOqQhn++ZGmUV15UcnQkt0F98Zr1cp2XCqNxCy7EglT
         A5ax1ewQLRbsREizz9edAGVpILDA+rsJA8FE+XrhAfx0H1vTFBzgb/wNxyubNPV2laOg
         YD20LDTOZDYqP+fiNp7WfGJVxPxdKhsHkFmgtQPBBmCiMheOsGOBRHBShXku6TXpfG2g
         VCAHEFTPSRXBhlKqSfFxVCWstB4UFOyuejGd1HSWvJZd+AKwD3fTlP5PZOcz/e8tXF6c
         DKoCQtG72tir7yBWhbgb70eMwcdWdkcPY8H3cW4f2tbw1eHybly+9r5pMc2ZZ6SvtNHw
         E7AA==
X-Forwarded-Encrypted: i=1; AFNElJ9NTJql0UVDQg1gKdgf69Uv9dJM1IOO59nAMDqjoPvtyqCAq4Sg97wqtKqhR+bSPNNgrsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sQW6ZQrUcxqN/Bu36wN8g8JLlSo/G3hIfoIIQQNpEMk2HdWa
	N9hYjcSsISTIXfDBx5QsRHl9fFbUg1srdjlxf82VdNEFp4IvYKLVSbSnf1ygjBjbEZbFe0ViCAE
	yfkl4Tg==
X-Received: from pgch29.prod.google.com ([2002:a05:6a02:509d:b0:c74:664d:4080])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a107:b0:3a2:d0ed:f1f8
 with SMTP id adf61e73a8af0-3af81372d5fmr3545884637.30.1778676521573; Wed, 13
 May 2026 05:48:41 -0700 (PDT)
Date: Wed, 13 May 2026 05:48:41 -0700
In-Reply-To: <CAEvNRgHfBqqC1K7enCPX3jqWE0smJ3E0NE=kUPSX7N7g5KQrvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511113759.610924-1-tabba@google.com> <20260511113759.610924-3-tabba@google.com>
 <CAEvNRgHfBqqC1K7enCPX3jqWE0smJ3E0NE=kUPSX7N7g5KQrvg@mail.gmail.com>
Message-ID: <agRzKWDH4lpN1rJv@google.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Fix FD double-close in kvm_vm_release()
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Fuad Tabba <tabba@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 12, 2026, Ackerley Tng wrote:
> Fuad Tabba <tabba@google.com> writes:
> > kvm_vm_release() closes vmp->fd and vmp->kvm_fd unconditionally, and
> > kvm_vm_free() calls kvm_vm_release() at teardown.  A test that calls
> > kvm_vm_release() and then kvm_vm_free() without a
> > vm_recreate_with_one_vcpu() in between double-closes both FDs.  Since
> > kvm_close() asserts on close() failure, the second close trips
> > TEST_ASSERT and aborts the test, or, if the FD was recycled, silently
> > closes an unrelated file.
> >
> 
> Never thought about this fd-recycling case, I think this change still
> has value in avoiding the silent closing of some other file.

I have no objection to invalidating the fds, I just don't want to make
kvm_vm_release() and kvm_vm_free() idempotent.  The caller needs to not mess up.
