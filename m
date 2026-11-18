Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794975282;
	b=NQp8ImDkZBHGrPvyOY9p92KbpbZ7Dj46uCi18MJCpkdywCUGGgBgVKvB1nOYCPwPVZpN
	 hz5PftFjs5dUkrtK0OpN8V0npRP0de67VF8B7MwAvbs4MYBMX/PgSs049v7lY0TQJPvDZ
	 BkVoAZVoUFK2kG+KiLNMJ0eiCQi78YK0sBsvSvNSdc7GYmPKuXw6P7tSIOV0e8D2i9Mbj
	 +Zbep2LUMp5x9s32O7Nyqs41jCPTxg4oc3H/8HSFMYko3zY+DNo4/PHuE9oiqoCxuVYic
	 uPduNX4u8IHmjtNirReB1mSDV30F3sFsnG/gkQ8a57tvAzA3LeXYazxX10aFqGP58Aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794975282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=78OEmd4BnQnAIL+/edXoWjTbrJ8v+9Ag3/ei+zWF0bs=;
	b=V8yMbrSkS1XxqLQUdLeIcc8Blg3xuNX1m6/kTMfC7Pw1Dp8EjwYhFsd+a5mkrUwGa+wH
	 +V9b2lzue/I2GttuNeaVSOJou+6LYyZK8iU7Xe+TsZjb0Q0bHgIUt/mIQIfWOTPE9IcRF
	 czVW+eOyhLQmy5W69HBA1berdMhGUGmPwKSlw3Oavk+3xWQ7TmFa/8lyraolRTWWDLWCi
	 d+H7o2vPiFaCwSjyRcSqNRd+kHfM56jzpXzsg+sDfF/ZD25O8YoVxaRl9ddrHtseuuHGk
	 ZBGHHZyAboFOyoKOAf8c5gDV+LeImV87mkiYDZqLrYbqR3kDHH47QQD7FnfETipZGUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZwrGQdVO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483B606A325
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 04:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D483B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZwrGQdVO
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b869ea8224so8150a12.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 20:14:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794975280; cv=none;
        d=google.com; s=arc-20260327;
        b=oD4RaHM5kbjJQOVi/faxDTQBol0RF4PjzbEV+cQrN4hVFpZQR6XCReCNvAygyIPcnd
         k4MV7xTApR4sf/263gwva6OUGP56IG+J/WCfoNC5pxF+iojsbevKj68aNbqZHkiEVD//
         II87GvXlruRemeUCxPCubIaSCXBEtrI/482Dt98ZFafrU19hjy9OP3O69Jb5RswRn+F5
         EmTqD89VlxVItr2veQpRMdtjAmpMN7CcPFoLFauHs3cUzkDXlMVlZezld5iqA7oDgm+C
         f2BYVq2WrbPsqx7+YLg9ork9n/hciQztR6QJ1Ft66PKBDm3hWd4g9Tl1tLcfkzya7JEZ
         292A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=78OEmd4BnQnAIL+/edXoWjTbrJ8v+9Ag3/ei+zWF0bs=;
        fh=5KaoZK38oGL4+sseBodJUdChWgc9XRMfj8VT0RbTyuE=;
        b=LpD1+HuFxnM4n3uvNa8P6Qy5L+PksRwBU2SSrfZEm0jDn0SuGq6dqns/7Qtwp0VXqX
         Rk82pYuJRa87A+Yat6sqV/31qNN7jejMlkIs2OUAdgXLh7o+Avp4hMMD82FYx7h/WDv7
         8Vb83Uh6wZM+vOjudNvXJxWg+F0oFmyYJGDRCqLT8P0B/a5ddKVJF+VhXUACphj+Dae/
         51Fn2S0bnhUOov4npcKyFIQmzwQlElweDjyAOvKmXReEQfZTSuc/eGEDELRbNgKlR0ym
         tx5wQSrqpdq9/CbMj6qVRd/Am/4m1RcKq2z5MAW/eCNoHYB+cm+BONgZETdT6z/+OtlQ
         dUiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794975280; x=1795580080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=78OEmd4BnQnAIL+/edXoWjTbrJ8v+9Ag3/ei+zWF0bs=;
        b=ZwrGQdVOZx99x9RiTFvQPYbMjUPCrWIWA5Vpv9CZuZFyezfx2BLCYZgI+4cIN1MuiX
         5fNq2X2flwYccLr6+ItVVqcxy1XskrnHVvEXCxRqjjy39SG4kZV9pnYyY14TBUpTSe5j
         lvG/+7+SKDT5RD4A1h4l+Ty9QKiofbp6hfPxVWNfDtRj4/IiwJoomhyfnAEODpB8uCS0
         3KWQFeXbJ1S4uRBiCSYnxgyhNHA88L7CxTj/puziZjKIGAXkMqLqO3Tj9uqi34UcsnYl
         ZczhDx8NyrdPzopRHr/mntTZ0kiJaZzNXAj5bvh5vucvXoHOCR+4z36pH8i1II5/KQVb
         Z8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794975280; x=1795580080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78OEmd4BnQnAIL+/edXoWjTbrJ8v+9Ag3/ei+zWF0bs=;
        b=X8SH0x1qBNDrL6T9SwGIniNIxLcr990j3SiMZPnZmQBoTkVYNfxuuCM7wY8ovemFOi
         F9LR5dXExlUO5wHh92zBHjkobOhYCHjR++wLCQjkh0NPsDxqOucrjtWRi7ZQVcpqj9Qc
         t5KdlJC8bfjHyomZJ04qi92MMk4JfHu1aT7ZRWun13kiATITRuVmZShe7iyQF3QaEefd
         vGNOKnB7DkRG0CpvI+p5015BfTWSYzxfq0rHXkx0lQ/LTMpSyIGSngCkDV+bh3NSv4r0
         1qB7sNsgA64qopY20nW8e1XYM9DyfPGnx7UiZr+toVLSVwhfxwDfOyUXAHCA+78uWqUG
         R4Eg==
X-Forwarded-Encrypted: i=1; AL+hErGAt8C45Cf26+pgUG1HrnH6ypCI5VAcvVNB3MzKE+oLkOmHmtL3g+hL44iE8v8mUIhcOWI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cpNamrQ3pcxloILlCgdOE3ZXzuP/Yj/j+TAUXcNdS5MZl10G0
	7++/S5rnBuZPv8r8datqAJxc8QuYV4TzStGfrb6kwgsI1MSkCWX0izj/03+SSiDp6GQsg3W5QjI
	+uaLSdc8wQfZ+e5UNF4VTLqkIelWhMPfLBth1L343SIhAuJfriUMDvJJIMBk=
X-Gm-Gg: AYBFou1wG6j3Oh94tm/c6jel/3eTp61i4dxxBQk1fh1rvmWFWCZwRNtnjlffG3jrQIc
	WCJ3YHGE4Ekn3thPWKa9FUcZ9yzWdq3Odp7+pw2S/h5fqSM+VqUQ+G5nUHUk2ZTTTuXaJz81QVH
	trF4mmlclr0h0NhSn4xxCfPEXL2QqJ7FnkYVUzExD2+zlmPW2NiqorSuhSH6Yrv4VyQD0pQOOx3
	SdU5R9tZ5mKGRi7IzxZsPqludjXLzMWd6sj2bz5Y6aTuSBFUag8IwPtTAsvsYZlsImEQ0fuNyq1
	ENwZhhalz6gVh3sHtvUm7BfNVCIEihHBLHkbZVO6IqN7qpFRwnbAzGi2RnRhy/Ek5F7hfy5KuQv
	MCVgrYmApbmWMTJX29nS6yjZTao5H0oPFXIHfSOqIGtIdFUT41gsRKwKOirz33KjS4hX8K3hQPQ
	/EA84Mdv6YNck1Dfpi/PdExFAQVBUxlJcgs/pB5R5m3DisktTDBMrk9w==
X-Received: by 2002:aa7:d687:0:b0:6af:afce:184f with SMTP id
 4fb4d7f45d1cf-6b88848206emr52162a12.3.1794975279739; Tue, 17 Nov 2026
 20:14:39 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117180310.921701-1-chang.seok.bae@intel.com> <20261117180310.921701-11-chang.seok.bae@intel.com>
In-Reply-To: <20261117180310.921701-11-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 17 Nov 2026 20:14:27 -0800
X-Gm-Features: AclHuK_6K2MkOrWw3JfAYerdh8WpXc2mA1P1Hxo8frcP4N9bk608N201LA8GG4I
Message-ID: <CALMp9eSw=ZBxMaHRc1iAXZaRi5Do+eDrd2O_YBWGFK5==3X1Eg@mail.gmail.com>
Subject: Re: [PATCH v9 10/20] KVM: nVMX: Propagate extended instruction information
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com, 
	Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:32=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> Define the new extended_instruction_info field in struct vmcs12 and
> propagate it to nested VMX. Gate the propagation on the guest APX
> enumeration, which aligns with bare metal behavior. Thus, define the
> CPUID bit here too.
>
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/aRvOSnaUt1E+%2FpkC@intel.com
Reviewed-by: Jim Mattson <jmattson@google.com>
