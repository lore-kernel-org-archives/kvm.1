Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A83EFD07
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289040; cv=none; b=CwnTWBinNgZdvf7vKBCL6QDaJ6yzNMcxLFX+/8QL406aI9xL27g7slRM4SHTh1HBv4mW/G4jYufbOaEiE31sTfjYixVurM530XNiO3l4Gz9FrcHSLDuhXd2unz+TEZEqN0dANA8xBsrFPVzHbJcXH1K58PHUbFRFsbnWou9Rz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289040; c=relaxed/simple;
	bh=ONPIIIyY4k4meha3TWbI2Rnt4CDFmbNxjT7pENMQtz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KqoFa9Xddf9OoXowSst6p7NZKfaKwM86N3HzYNg53DsyUZxCi3sFXCGEQicyK1higyUGjvWqIY4K2iVOS3IbiQYxafA/egyjuc79VXQ58Cf/ko+a/g3h6RhVJXnxQ974JOwZ/vN5NbZ0+n9x/dlkVQ6MQ1YBJ3qb138M9Dv6Pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BiCZHgs3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiCZHgs3"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so3210344b3a.2
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779289039; x=1779893839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NrbYoJ1QON1p7OC6Cqv0OkZ3xgkKPZfPCIdW+9ujN0o=;
        b=BiCZHgs3X152CE9FVtA8GbB9Fp2FhU52zXAaNHeZb44mrCrwsEqNUcbaQunmFQcdRJ
         OuLfSboUUojaOSEp2KQEDA3hLJfn3mblAnSc/hrlzdBtHPZuJFH6DE8y4FPck8+9IRJ+
         uuFINTtOO/DLxcqrhelLxe9GjIUgGqgKnMBpJkhg92dKt+19W1VqxQxAbClY/GA54yso
         UTdTbw0Y330Zzd2a12Wd7Ffu+4Q0fvvX1eWWjRoNrvkdegkUFisgZz7e0HUKqrJQzK/J
         1y+vQ6RJk9NOkNUNew/0HE/Inc7HzDcRApX7jVWlNXlRbPO2ojgs5gDp07U+VnQ19lxX
         IHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289039; x=1779893839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrbYoJ1QON1p7OC6Cqv0OkZ3xgkKPZfPCIdW+9ujN0o=;
        b=h67b5MlTnPP4nYYevUmG6FwNB0zO8LGsXZZggsAw9gLf+OVZeW2oXCZfvll0YDtmbM
         xzWvg6B1lq5anca567Inv6Tcc62xHUQtvGxD1+DtNwKVUkKeZroqsd7dNyCL/yuvANGf
         KKA08NckA+cR95MngXlbIMqRPACIVUG78LYsGu8nWH7WVBKJm9i9GG5xieO4RdhTLdwx
         OWQdvYrcVyhKzwy+ejq0lsjzF2Mnj2aP46rw0Ns1+BFnR8WSfXVfiXgfuqo0zO/NmNBx
         Lzd2JiGQzQOrjWur9gx2BMsJYSRvcaEdU6z0isB7CBIBR7R3jEZrjvZ624C1A3JpM6ze
         N3oA==
X-Gm-Message-State: AOJu0Yxg8PkXNP7WHHC/x8xyrJop5HXQzfvHAe4yEVoJi/e+SPGX0Zdo
	BnsizwX/ES5vBh619zWkVfgfwutATkPqqgalnMYkC5OBTAbQXPx3iQds2JWrjTIcFllW10ivEMR
	BQXkmyw==
X-Received: from pfbg2.prod.google.com ([2002:a05:6a00:ae02:b0:82a:5ddb:b051])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4508:b0:82f:3436:42d7
 with SMTP id d2e1a72fcca58-83f33bcc799mr24905952b3a.2.1779289038879; Wed, 20
 May 2026 07:57:18 -0700 (PDT)
Date: Wed, 20 May 2026 07:57:18 -0700
In-Reply-To: <20251224014324.1307211-2-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251224014324.1307211-1-chengkev@google.com> <20251224014324.1307211-2-chengkev@google.com>
Message-ID: <ag3LzpVEPuZvCXAQ@google.com>
Subject: Re: [kvm-unit-tests PATCH v3 1/2] x86/svm: Add missing svm intercepts
From: Sean Christopherson <seanjc@google.com>
To: Kevin Cheng <chengkev@google.com>
Cc: kvm@vger.kernel.org, yosryahmed@google.com, andrew.jones@linux.dev, 
	thuth@redhat.com, pbonzini@redhat.com, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 24, 2025, Kevin Cheng wrote:
> Some intercepts are missing from the KUT svm testing. Add all missing
> intercepts and reorganize the svm intercept definition/setting/clearing.

Please split this up.

 1. Add helpers to set/clear bits.
 2. Add helpers to save/restore intercepts.
 3. Reorganize
 4. Add "missing" intercepts.

Maybe #2 and #3 go together?  But there's _so_ much going on here I genuinely
can't tell.
