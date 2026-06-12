Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7223385B6
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225293; cv=none; b=P2ffkI8Lb5wyKLTVzncxzEpdO+dzfzqbOdQm4ykOPw6qSPQqMpKF787MgilGBIXhKnaT1Sw8VG+iB1yDY/erkE5pnMx1Enfg9ig9olr2MxkSgsrrbcG7chMlUAkFywtyI9KjHsde0uRvRUOseCL7VOB/8GLgZ1y2UoSMbkjNTLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225293; c=relaxed/simple;
	bh=rAUlHF/XCFOEqeqxMPI8u0diQ+7m/md5yEh9umCM2w4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IiRTYseu8Otrt8H0RAWnr0oOw4SmsnVr7zYv8M7ULg5GeF2fSbbkPOvgb3icAU2txZs9ErdQw/3aJDU+I2P603vs1woZT+xxtj2PKGL9JHrey5fDyeyquMDEFeZ2t7xlGziu5SIyy6ZGbllwwi7YQIktNt9+wjqw3MR6ecNNxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbToLtSE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbToLtSE"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0a99db8dfso4119015ad.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781225292; x=1781830092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXt8ixv6AcemQDIxqgXhYP4FzT3uLEkcO9husvJPUpg=;
        b=TbToLtSEHBP5CMFlL0EzEAunr8Fg2oOF8Ta6MhN2avvM+hyUI3bp+awKlgUrHI90nV
         ORHj1WqhOouM9xm9nN4MJBuMHM76mkoixXgeXyutvmcMb9Dku55mVFWUWP8QenpojNkM
         jaZOedKp2Ll5JgFVDVCCw6v0Lq9OHLKVJGUynbFqVnrJ3ck5rJ6fxD7/fk154pH7ZwCe
         Ek+9i5F5XKSFKstPKJVXz0J0VHYSBMur7X15rlCc40UIPF8ov5KnRTifMExoA6GyjbiZ
         QqkjAEi4J6Gq+y4P5uGcM6sGYCL4qlqnettZp/fIK+on82NT9D9eRiVWNMs6o8fMFKBk
         zk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781225292; x=1781830092;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IXt8ixv6AcemQDIxqgXhYP4FzT3uLEkcO9husvJPUpg=;
        b=LFhC1JSpA11IkA2SaGQPWVBIq9g3gq9uqRlXxRDavpewzWPKVbVYfkYs2PNIg4gIYl
         v3mgoWr4DbUSh3GPI1+XaB8X9Dcdj3pbcvzcqZ45KgpSrktNW2/6XI8m7IU41xYXPtHj
         n+y0Es7ak4ad6AysoZHMiCLD85aG4p9Q67oGukvw5Mqs/g0BLYjNortRrYDDYxDBZeQo
         ynsoZMbHmBDkVZwuD2brE/qhsMOLpQDS9/H+EKIQUzu59ccAguiFdzsstH0z0l0RiS04
         lmr87scc0AkcRKVmJ1iEpFoYbALaY+J7yWzyuousk2ouqX9TkSY+ILrKXa7lXuAtfsoy
         IQdA==
X-Gm-Message-State: AOJu0YwF+XjtE8L+VQjLg7Or4iBwtTMHc02VObq8VwsGTD84hg+hUovO
	cTtzwwBibKghkk3zy/dDkjbHfGarZsxicwqvuZK+MJD7nmiHXC8VcJh4Ejted2zw+ovjHJNNfHE
	v/wkyAA==
X-Received: from pgge7.prod.google.com ([2002:a63:db07:0:b0:c85:104d:a751])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:da12:b0:3b3:4406:202c
 with SMTP id adf61e73a8af0-3b783b4f296mr662155637.10.1781225291600; Thu, 11
 Jun 2026 17:48:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Jun 2026 17:47:53 -0700
In-Reply-To: <20260612004755.349925-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612004755.349925-9-seanjc@google.com>
Subject: [GIT PULL] KVM: VFIO changes for 7.2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887=
:

  Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vfio-7.2

for you to fetch changes up to 156615264fd3430e7f90b36f46076b2f6ec4a24a:

  KVM: VFIO: update coherency only if file was deleted (2026-05-13 11:12:40=
 -0700)

----------------------------------------------------------------
KVM VFIO changes for 7.2

Use guard() to cleanup up various KVM+VFIO flows.

----------------------------------------------------------------
Carlos L=C3=B3pez (4):
      KVM: VFIO: clean up control flow in kvm_vfio_file_add()
      KVM: VFIO: use mutex guard in kvm_vfio_file_set_spapr_tce()
      KVM: VFIO: deduplicate file release logic
      KVM: VFIO: update coherency only if file was deleted

 virt/kvm/vfio.c | 98 +++++++++++++++++++++--------------------------------=
----
 1 file changed, 35 insertions(+), 63 deletions(-)
