Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBBA2E7387
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604513; cv=none; b=dV95906DIJA0UBvfXj0Teq5lkIApdW3keWmpElEpkh9grCcK4Q2jH9xjRqZ+YUVGQQqG21naFqZ01otoKWAda+UKJD9y1lmfOrTJRTwYd6eM94CDXNhd2Jpc5fz8nsBCE5RZ6oH10CMmTjsrCgGlpI9+Lg2sLNjdr9pRWHV0EmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604513; c=relaxed/simple;
	bh=fXsjiN6eTN+wejpC+aES5Y9JD9oLQdMfLq0AYbS4o3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tWTFqYa1XgHOzoRXIiERr3xDgXwJdPc4Rqb4DEBMYROi3uTy6eFZlKxnbV7EUtD9sfPBExJr876+RNB4PfWdbbNWu1vP4Y3G3Il01SxJ8pUj1IKrJDIztaL8i6Q0poU/mMoaT65ovdV5LgthyySzGd4aB9UdV5Zsr3+ObwEBJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZdaLUyP3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZdaLUyP3"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8482fd61e83so3291236b3a.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783604510; x=1784209310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TqZ6gSD5FKoEf+kRjMwloxjdQe2NH3vzfgHgIMmv9+Q=;
        b=ZdaLUyP3F7jnnDJe7b5JCvFsgs83DVmWAG8S6Y84TGqNRkI8qFDSy3CQvn8wEoEQhO
         naRwbC+2fZJ2UWrcsnUpfh0jTG22ZR4CwH4nU2DhRnTYLiiPNh2NURnxKW5sNGe2zPLB
         lOvxU6/7hg8IHrOVorC26InJ17jVstdt5oqTKYUpaGr2jBI/KQU3UDwjdiF7VQ39Hcul
         AXb58vUJ/eGKpRATbDelAgiD+qInek21/fps6lr1CIFl6DMMPaTAIxsBC/+tyeOGGQT5
         bzm48xKCApPM48kCUEfcogOFylLXbnp4WJsaEPyUU6gyvRTA7qeJLLAoNX9cM81/GF41
         /kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604510; x=1784209310;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TqZ6gSD5FKoEf+kRjMwloxjdQe2NH3vzfgHgIMmv9+Q=;
        b=kmXzT7NqtqEsK3cSyWuVG95ZzehX6y4xuj1lQTHdHNDpcFEhcvyEPvdqYiUp7Vju5B
         I0Nsfci+FuGHP/ffyAVc99DfkW4G0JRw5wg26YB8UL5eff5EakqYXIrD7kfjQH6+9MPL
         chiTV9hk1wKePKhgDhEe/Mi2NuSx/SF8JejOWt7YBmZ4VX/cWDUfPXIgja18kBzFCGeI
         LGMIIV9RwyB/1m6a+OYtyT3y3fuyix0i+8ZB1w4xt1LkYTCLVolTHIZWIgaG6G3cwt8d
         bCu4FKVVpR49HOUU+6mW4S21DtE/arOW6InvOEetzcBNypqlsjk+/LgJwwDvymcDQ6Ec
         SF0A==
X-Forwarded-Encrypted: i=1; AHgh+Rr/yAEID+90GwoGaRnku3XjJe/q/kznZmU6d2UVL38160PEldlOqSNM7qXLggzyTu5KUXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtzY2/OBje+qyDdJuWfHlUezbu1PtZ39aYgfiHAHZQKMWKhQy
	U7vSH/huMtS4oyYhXrsQzm8tDywbKIxb+w53RPsAArtbqz9TjHQmGjLnxBjuiTYJ9mord5laeHP
	4jt6w4w==
X-Received: from pfud15.prod.google.com ([2002:a05:6a00:10cf:b0:847:9be8:84d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:148f:b0:847:1d73:f753
 with SMTP id d2e1a72fcca58-84843410e48mr7508657b3a.45.1783604510194; Thu, 09
 Jul 2026 06:41:50 -0700 (PDT)
Date: Thu, 9 Jul 2026 06:41:49 -0700
In-Reply-To: <9d376736-4879-42f2-b798-56fd2d1ab05a@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
 <ak4NdJSK60zKD8Uy@linux.dev> <315e969a-4ab1-433e-91c5-2308f1975281@linux.intel.com>
 <28ec0a5ac5c46448df5983cc7f9cbc71f6014e8a.camel@intel.com> <9d376736-4879-42f2-b798-56fd2d1ab05a@linux.intel.com>
Message-ID: <ak-lHS2edzxcmT1j@google.com>
Subject: Re: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD init
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026, Binbin Wu wrote:
> On 7/9/2026 12:20 AM, Edgecombe, Rick P wrote:
> > On Wed, 2026-07-08 at 17:04 +0800, Binbin Wu wrote:
> >>> Maybe it would be better to check for a mismatch and return -EINVAL?
> >>>
> >>> =C2=A0	if (init_vm->cpuid.nent !=3D nr_user_entries) {
> >>> =C2=A0		ret =3D -EINVAL;
> >>> =C2=A0		goto out;
> >>> =C2=A0	}
> >>>
> >>> That would make the mismatch explicit instead of silently accepting a=
n
> >>> inconsistent userspace snapshot.
> >>
> >> I chose to use the snapshot value to follow KVM_SET_CPUID2's style.
> >> KVM_SET_CPUID2 kind of uses the snapshot value of entry count.
> >>
> >> But returning a error code is OK for me.
> >> Let's wait and see what others prefer.
> >=20
> > It does seem safer to reject input than have some implicit behavior.
>=20
> Yea, had a second thought.
> If there is a mismatch, the userspace is probably malicious.
> It's safer to reject the request when the userspace is suspicious.
>=20
> Will send v2 to reject the request for the case.

Rather than add a separate if-statement, I saw lump it into the existing sa=
nity
check on the cpuid field:

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 6ff1469e91cc..10b4db17fbd5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2797,7 +2797,7 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_td=
x_cmd *cmd)
                goto out;
        }
=20
-       if (init_vm->cpuid.padding) {
+       if (init_vm->cpuid.padding || init_vm->cpuid.nent !=3D nr_user_entr=
ies) {
                ret =3D -EINVAL;
                goto out;
        }
