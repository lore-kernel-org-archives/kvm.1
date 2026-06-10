Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F13093DD
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108365; cv=none; b=Oxv9VMivHvT5Vcr2b+jQRu+7t+7e8lNveR4BQMjBAOqnkpwyDOX4KukGvQKbXx5GQiMP67h+DXz0d85457LRMKjtj0Cm9gSrbD1W2eV5rII4I5Yr/wP8yWTPGMAM35tZ35mBdLX9F8qjthd6BTDVXCHC8UZjKDCvXZbBCu2BIto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108365; c=relaxed/simple;
	bh=cnizVXfGyNcDUoAO1/Ywbc3+WVGGnQ910kBuW5FEIt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ddRYl3AN8S+H5xfiGyUW2oxsDmEF+Ox2yueTwA6mJaql5K1IcWoDHSFlZkbQ+BD3qTHW/uAtV2j20X8VrtCO0jaL7wsgA+EK0NVl+zIcH//LzPZKopJepmI8GqsiBREmvT3uX2WSVHudXSiAABbMncQ4B86SKumLPhVpEKyYDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLRXTI2e; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLRXTI2e"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a2cda4d0so3597427a12.3
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108364; x=1781713164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnizVXfGyNcDUoAO1/Ywbc3+WVGGnQ910kBuW5FEIt8=;
        b=kLRXTI2edMrtx4TdC04J4DO2f5cFVAgLQaYSsbSoCJwzzNUxrPkC1psIW2YNl+hvUd
         EYhWFMW0QumYoqifKpyEX1vLtbq4kIk+nkDv4E3cob/4SXg0Z6IkO8DfXmp3fGOZ1arZ
         ZTn8Nj3uDa4U4O5di7gjuNfN64yr1He+ABVyEhyyLIU67sFk0W9hTwg9dzH2fX5cENBX
         juZ2nPC0/N8o3ZHwxANYTxVyrrsSKqQrX3lL/DCvZY+2JjEohGNxyPIHiwOLKrhAiXfO
         vJ5jXqHKYX5HQ+lqaEFJxATrWjH0C6+B2Rcem4aaD9kmqAepG7YfaZUALIm2Owf4iNiy
         z6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108364; x=1781713164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnizVXfGyNcDUoAO1/Ywbc3+WVGGnQ910kBuW5FEIt8=;
        b=EL2gSWWJKpQ9quVGYs9q0xC+7rqpBWI4vCIqXkhVW40CKHkN5Gm8QIX3EfpJJh2mDQ
         OZ3kQbKAz/yGEwQM5wZ6xrMWKHDAHmKUssKBewwk0+H34hQ+WzDQj+l5gt0qyLRpVXxf
         pE1VXiGCWg0y9O7GCu4oRa46vQUy3j73ZN0JvChPRoP3xmE8k9AGxsbNWe4Q2Gs0x0Xn
         jcJmuUaNxV65nMZ+6Qpwx5E9ciUDJia6tEsCm2c0Fvr45KG/yd/2MYW4+C5ZpnkHyAXh
         PJ/Su2pOFYjnaKcxRpRoFiLaAZWCsOg1svPC/Oc/CLIX12L89ELG2zUkSeUC+rr9J1Nz
         94GQ==
X-Gm-Message-State: AOJu0YykESx6W2FA1iLlBcWbtZUABQdq9M/fUCduJ0W7y5V4dSbhaOk7
	yc35ff8f8xWPdOgn6qpPpFeevNBaCD8gIH+Y2tDRyWqrNfl/USWYETJyYHeHuPIXsN0zBW2690p
	UGV7Uqw==
X-Received: from pgbdp7.prod.google.com ([2002:a05:6a02:f07:b0:c82:354b:8e38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1f8c:b0:3b2:86e8:a817
 with SMTP id adf61e73a8af0-3b4ccf7f0d7mr31791362637.31.1781108363531; Wed, 10
 Jun 2026 09:19:23 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:19:22 -0700
In-Reply-To: <o6hieeub.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1781093720.git.ritesh.list@gmail.com> <aildxtZhqEFYygp2@google.com>
 <o6hieeub.ritesh.list@gmail.com>
Message-ID: <aimOihmFdNIK9TIc@google.com>
Subject: Re: [PATCH v3 RESEND 00/10] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ritesh Harjani wrote:
> One other question - Should this go via powerpc tree or via kvm tree?

Definitely the KVM tree.
