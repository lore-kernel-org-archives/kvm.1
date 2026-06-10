Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B25477E
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114361; cv=none; b=VkVGFfNhJhfWq2s5Hinv8vAkA0HpMVaN6gEwc5IIvQbsKmncnUxmKDVnrxGhXF4OJfSLr4pqXF75sukIaEEnpbny2m+4oEyiFx/t53TAxKmSezoy5Abba4sHrc6NaB0M6Ocoq3SIkaaIO1dC/Luxf8YPRqNyA65o4BDmbuFCdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114361; c=relaxed/simple;
	bh=ooQLKDt4t/umsUYSpGFIHEX7BwMgJ6SDbR70bsEWiv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HAz78CM99ndxlqAVhhSKNnYhuaw4ZJNJ8o4Adh3I08sqzOowpK/Z+Vki/O8YHGG8bZ0PQva0KKqOYBSFJealtWM3dYrOr1BUpz+L6GhytltiPnDCzQ+1VrfSUJozPYhtE2Sj3yyHP8mKtNUsJaJNB0AWic1i08pGytIQCp1JJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uS99sxT4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uS99sxT4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bcfce8a33so70740a91.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781114360; x=1781719160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUrC+jAn2iYzK3cyoAqLDZt/8SWBUONJdIH1jABrZ7Y=;
        b=uS99sxT4TS+HKgVBsegCJzGGFhOP5gUFRc6fMVWN9MDz2i6or8KSVzsvlknlT7ff9k
         5ON/PVF8Nz77HlxIfMqRyDpxP9grKB84qrOsVIcjIc2P8NmM6ala1NT1dt/RZ1LE9KAZ
         nNbYO8m4y76hrdQtJyvywEgodMtS66cXPzMPE+0qOXc/tjKeHkVRTy1zuVOQwCT99rQm
         xUmW9jempWGCHOWmYQEOeUcZ8cQY2+hLEA0H95NC0eM9N1JzF/YF1sBnQE2aO2B5PseP
         8zXa1IaN2sk8PVAJwvrbsReqrLURTUjf/cviCwcK9ggc8n2kFuWyFnkUhSNLWaSiry2n
         mhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114360; x=1781719160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUrC+jAn2iYzK3cyoAqLDZt/8SWBUONJdIH1jABrZ7Y=;
        b=GdDPQ6nSnkg3UVedbbMz7lUJiWjI4m3IkUv5MYJMwiRhlFWorfxwmUuYyXpX2FsSTA
         DPbh5hRAXOZh+d6RGGyI5h8hq2CaADsr4nFb0HJiAYJ94VercKSo1suY34Vj+2wJMOgY
         5NRq4vmVsYTI2C63N/ZYepQ0MpNgFL0SNDVF3jvyTAf1hOFjTd/kwiM8JpXft3LCQLBO
         Jqj9fJhk1lpGFa9soQwraX1ZimX03JfWxxGungLpkhlFK8Vj6ZDKEdUR1Y8aB6NS+M8o
         MQ/DZRqaiq5w4XlXVvdt2jHI50zMSQlGBjtWAT33GXtkcAsiq47Y25Ho5VXFuDMA81S8
         rvRg==
X-Gm-Message-State: AOJu0YzOcRy77UX1xl3UuDKf3LVGZL8gDhHXWgk/Fj/slleCvbws9ZVt
	bIiI2yMZ1as1d4WK3tbErrhyrxm9Px+DBhYafsRAv6uzCAQ+dMP9DEunx4rA623pr3awP1iutEv
	hpTJmhA==
X-Received: from pjut3.prod.google.com ([2002:a17:90a:d503:b0:36b:bc13:f5a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f46:b0:35f:b9f1:fded
 with SMTP id 98e67ed59e1d1-3713336f91fmr19807082a91.12.1781114359586; Wed, 10
 Jun 2026 10:59:19 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:59:18 -0700
In-Reply-To: <ed1d75f27a3b02897a8f54721d9f7f21bb163d9c.1781093720.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1781093720.git.ritesh.list@gmail.com> <ed1d75f27a3b02897a8f54721d9f7f21bb163d9c.1781093720.git.ritesh.list@gmail.com>
Message-ID: <aiml9iB_vUASRRQV@google.com>
Subject: Re: [PATCH v3 RESEND 04/10] KVM: PPC: selftests: powerpc enable
 kvm_create_max_vcpus test
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
> the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
> VM's limit.
> 
> The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
> to the kvm_create_max_vcpus test case to limit vCPU IDs to
> KVM_CAP_MAX_VCPUS on powerpc.

How is this not a KVM bug?  Literally the reason this test exists is to validate
KVM's advertised KVM_CAP_MAX_VCPU_ID and KVM_CAP_MAX_VCPUS.
