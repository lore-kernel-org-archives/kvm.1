Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72713C8E8
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 03:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532214; cv=pass; b=pWh6smWgkeeszo8AJCeBKLSSuOS3AWuI7iEr0DzMcNmNjVY6HlcgDGHhvAjvbZEnPygB/mJ/SV7q2m8AZDHMN0lHeYmTXezLTtefa2fgSIMhkAlU99vkashT1VY9BEuJbqSKLP7xYBnQ1CKXITmJ7eCdoWbgnq8MGj7eWslW5eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532214; c=relaxed/simple;
	bh=OZRJxBkOYW/2Utyno9FScXd/o+DvAyAr1XUUWvX04mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHqIxRirHG+yDUnlddl0s8Cvhxu5Qya9q2YBoe8kvgwUlirlx4palCrzdfkJDCTeAtR6yJs1VXPd7vPsMHYxbEuLjgkPk8JoDd6S71jCe5oSYNLFMz1i/cpKw7dB000V2niqFgN0oJeBCtsP76VEus03JiClZVsTCs1Q7GSHe7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dc+aB0Ty; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dc+aB0Ty"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso29021a12.1
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 20:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775532211; cv=none;
        d=google.com; s=arc-20240605;
        b=aiqIza0pjl4HMe46MSKCa6MAl0n796DOx2xwH8w9dNVkpcJmkeH6uTEe6JzxSDdOVs
         un7/yZP4/qVm/Kb5d3BdxPzhKC7uFeGC9uTDJ1p8fyopM6oVO9Wz6IF1D/f3yfjDXjMw
         depgDZo2dLy9MMMU6PnpzvmjI6V9/Hxs/35oMRAP209Eu2+RBjSeOmvGQ7B/E5wqwunz
         pgBapesrfKGF6Mf9dFsr6eWg9R7Pgb810osfg0drCaW5SOVjoeDXHYZjsi9+hG2mZfAY
         SZs2wANzDbynJGJaTcfH1sMJVhKLn0gPwLwIIpLjWOx322h78c6ptH21qatE3I1kWg2m
         wlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZRJxBkOYW/2Utyno9FScXd/o+DvAyAr1XUUWvX04mc=;
        fh=IxEFvvy44gDEv1XQaYoHfyGMIO22PQyLRm+7HnmNzOs=;
        b=RCA2cAmdxGDyroE7Q2oishom4LgKVCXNtFmX2liIJrPqvTHIh2uzy+YI6urgkADLsp
         YzsRbH4+dYvQ0mXKlN1TW4dedAo0CKPxOsgBOE8NIEIyjQSK+row/CClzdoeAoXbEs0T
         4gsmcFnZ2BtGh3Qi/I88MqbK/sNBFHuiiGP0OF9OklUwocv7sVchPeKj+UjXbIajcIZ4
         mUOOVh5g3/tOEpImYVMGDv/tVQ214oExVleB2wtsmnp5lh6qOL1//KmrvDY3ZlhUlarE
         y99wt50YT9/zeKEDAm87o62NZbIu3CncuNvCqMV9oVQLlVXevPQo1MHTF7hT6goHbKcX
         JTDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775532211; x=1776137011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZRJxBkOYW/2Utyno9FScXd/o+DvAyAr1XUUWvX04mc=;
        b=Dc+aB0TyV+LAwHf/2qbMOlxPt3+rPWYmvgju/QKoo5Nr0VOZzC2Skn2I1w2+9Mncd+
         Jqq+HKr+Bxmg3WzvhyrM3xK/tyLtLG9yWIOx1C8+e9J5+8VHpVhFjaf2x89MNUDUONZK
         sDWUN4zPG2LKGtrixKek9vwMUxUnne6lY82X9g5OcQZOrOYjlpdWeZarB+Ut7h9tl7NW
         6jp0MstmooUM1JDoT/txEwxlFxYDeQzu8g8ZWtsJhK6z7UBGQjO4KVEDvBT+ogYzIdno
         P2k1x69oIXp5OfjvsQQw428PSNgkZEyPpVeYgYahru8JmcPHVMdCsel15Aym0P1vGbcI
         m/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775532211; x=1776137011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZRJxBkOYW/2Utyno9FScXd/o+DvAyAr1XUUWvX04mc=;
        b=o70TH9yDc51Mr4BK43P/LdbzKQXX1jGBzVtabpRuZ5i3yJ3trVDvCEA5HOXZq2Xlt0
         bbrj4C0LelGgVq0yp38PwAaaQCkVanNcTkaYITgHph7LCkMlLzitOz7lSHptHtlHpYT+
         6yU1cjLImVtr2GehWJA58rLRJbGoBl9ZJPi/XdLca7M78AZiwmRmVv7ILMSlWAzICK1c
         i0RakGjxVr2EkU8MwAi94PqVsCAqGqfs2UhT7bA/cTfimdOSNMvZojFwZVBwQRHOAbEj
         KYF5TPvJuKGKz0bIL1nOWCOlxJ3RDz0ENk9Tzv0sIimD8rR6k6PhfOBYkBzXMmg/s7dY
         Kcxw==
X-Forwarded-Encrypted: i=1; AJvYcCULgZ7CUMuLfyVuGZt7ydGnvKYKiuh+wd9YSUfYS4WPS2q27UQYMpkPDTQuN9mLq8S73Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOMq8Lyo5YesjTXSHFdZh502nN1UOrfYbAhInTuWOUyjzP5cZU
	cE/kkE8NAYOQwiJJMQghcaLSFHl0YgAFiBjwjRX45/gurtzYZQmSaKeT7q/EXGKC1IGBThLA2Aa
	B052oDQ6V0tBY0D/JKm2n1GoJKD9OcOx6RhaNs0BB
X-Gm-Gg: AeBDies6lUWsQ6Ua7bBj70j1STWzOHsq1YNV+h/HGpJknEd1YXPjhVDeqfA8/p/kQ0b
	8PErY6Jj3ic1owt61+e/XHP3iQwgxuySxbjvlZEYLj3YhantXt/iVaCoV0hdxvKbBW0mvkXn14U
	UcJ+rs9V8EYuyaz3pcQkXLdyaLrbZoUUMSRgUy7iu9NpYjKJq/XVvue7rxomjb5RS3AyjEYLzNs
	CwH5d7u55E1Qfww6WUFsBAeeYwpPROp0G7kNhhOiPtpAmVkSLc5Zx2ssKkAo4ahmfOo0w+yLt6d
	NRC3Khw=
X-Received: by 2002:aa7:c383:0:b0:66a:7b3d:f43a with SMTP id
 4fb4d7f45d1cf-66e43cdc3d3mr104040a12.1.1775532210433; Mon, 06 Apr 2026
 20:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-7-yosry@kernel.org>
 <adRgNinmj0V0h6nH@google.com>
In-Reply-To: <adRgNinmj0V0h6nH@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 6 Apr 2026 20:23:17 -0700
X-Gm-Features: AQROBzB3S4Pc2i5WIF1mdlL9mjL55Y3fj6_EC9pCqpLfZeZaKr0u9QKfpWRixgY
Message-ID: <CALMp9eRUudjZ+o3PUZ=dO9QHK5wiKDjgvp2OQLj4F=Z6LqozQA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] KVM: selftests: Add svm_pmu_host_guest_test for
 Host-Only/Guest-Only bits
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 6:39=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:

> A blurb in the changelog explaining why _this_ test needs to honor alignm=
ent
> while we've managed to squeak by without problems in other tests would al=
so be
> helpful

read_counters() induces the compiler to generate a movdqa instruction
referencing L2's stack, so the stack pointer at entry to
l2_guest_code() must not be 16-byte aligned. (Odd 8-byte alignment?)

Presumably, we've squeaked by without problems in other tests, because
no L2 instructions have required 16-byte (or greater) stack alignment.
