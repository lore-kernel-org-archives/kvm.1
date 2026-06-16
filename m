Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FE47A0C4
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630398; cv=none; b=MlLnB2Cx4niX8KwJQaQM3S18zG4N0PIQeiG2LPXn6m1TIyLKWjUvPUyEeXYtjRxBgneBnaO3//xiqmqI0kyGW3JMlTHRZN+0wzyQ1yO3j2L34bXOxtPqCzvsTjxVdzSwtyFQr4GWbD7c+Le51dum+alha0v6Ba2Bwul/8d0ac9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630398; c=relaxed/simple;
	bh=A2+CK1B5QDU0Y/41N4sBO6eCDiMB5B6aEK03PsbAxbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eIMyEzHBZeZDC90a17z+gevN47Mt5zSw1/JJvoFZCvKRN2pjQWGDmgVPPrsa9YXwoLps29IkZlpA5KvEXB2i+FJJV+taLrVHkFcUxHy5y7Ll0ROcrZnHi7qxFxukCt7s3/XAN3jD72NBdDaT0E72oXuJ2L4zqFaoH06ZA6/nBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjkpar3D; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjkpar3D"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0d0516ad7so47329675ad.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781630397; x=1782235197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSIX1z+B9fvZSD/oleB2wG3Yl/nKHAmrCSe6r77T0Eo=;
        b=fjkpar3DH73AXwmtpFR4UQhRAQ/9szfuciIr2t0HkLhn6ApbyhQdwV/mgL8tCwSB/V
         92pSSh6O4knuS1DOMMZIWQLSV9gUIGrWMxrYbqeRWnXJ4rOAVn/kFs/gz+Acbnhjl4pA
         SwAWkS1RHaZqnLFJySo2ojRuaB4iW5BUD8ibylDmVXDiZO7tEtC/y909vRUuSrYMOT94
         /0pdznzl9JxXzvOju4EmFB7Iisszrle2D6BzWyZF7Y7wvRsasSo8MmjqALiDBtEOsm74
         nz4sBvIJB64YqcqxYcuJVXrxoHN+H9E7zTdlBN+F3Y5vSoVfk+Qw/O2CCk8ts/RI3iVa
         s1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781630397; x=1782235197;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CSIX1z+B9fvZSD/oleB2wG3Yl/nKHAmrCSe6r77T0Eo=;
        b=oYkaEvgncOqj7YimKvmlcXJZaVSTMzpVqtPuMg+ci1afypfZ20/oXvP8dMg7yfOy7W
         vdlutzSWulq+BgqNiwAylbXyqjMFMRUfsYOqjzBBP0mJA5EKOdG5tCuPqt7W+QNsACMJ
         vq+p0Aab8Io46i8UiJdBmekFcZd+wFs9tyl20nzWa27sYG9kvzeHR1TU4Uw+J4H5uwNs
         fA2UjH+b4gelwZKTJK4cuxAYPk16RepUdagJhhkMZeujB9IEbtXk6FeQjHL9vbMZe6bz
         Oonx7YoVcKhJ4naRtz1QKS7fsISuXuqJ3bMOp51mCeSxyahoDiL8/DMceJD9SoP3sxVt
         Q3sA==
X-Forwarded-Encrypted: i=1; AFNElJ8QALevOnCYFEsSkrVHKNO0pSu6s+SwPqeeoBzHG+npRAf5/L0PTzVIoj8TdVt+a22ErQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKYd/BH0qJKDIq2qYyPYK/t77udt7KeayGqwL+oAoaPVrRRPv0
	BW/m9BwIUYHJuKn6UqFQHLlwD1OiWpbl6nOgU6QQP9fgNZQ7cp1ARM40HSyslNqChVe5Ud8wDFy
	Jj5En/g==
X-Received: from plblv12.prod.google.com ([2002:a17:903:2a8c:b0:2bf:235:ff11])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64a:b0:2c0:cf44:3b3d
 with SMTP id d9443c01a7336-2c6642078f6mr178066825ad.26.1781630396651; Tue, 16
 Jun 2026 10:19:56 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:19:55 -0700
In-Reply-To: <115aeae4-9d07-4872-a4ad-a776f4ef34d2@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-10-seanjc@google.com>
 <115aeae4-9d07-4872-a4ad-a776f4ef34d2@linux.intel.com>
Message-ID: <ajGFu1L-lQ4L9lO-@google.com>
Subject: Re: [PATCH v4 09/30] KVM: x86: Move eager_page_split to mmu.{c,h}
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026, Binbin Wu wrote:
> > diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> > index 0eaea2d4fac9..d30676935fff 100644
> > --- a/arch/x86/kvm/mmu.h
> > +++ b/arch/x86/kvm/mmu.h
> > @@ -13,6 +13,7 @@ extern bool tdp_mmu_enabled;
> >  #define tdp_mmu_enabled false
> >  #endif
> >  extern bool __read_mostly enable_mmio_caching;
> > +extern bool eager_page_split;
>=20
> Side topic, the attributes don't take effect for declarations, but in gen=
eral,
> does KVM/kernel coding style have a preference to keep it for
> consistency/annotation or just drop it?=20

No, not as far as I know.  Oh, nice!  I was going to say that I don't have =
a
strong preference, because I assumed that conflicting annotations between t=
he
declaration and definition wouldn't be flagged by the compiler, i.e. that i=
t'd
be fairly easy to end up with stale annotations.  But it turns out that's n=
ot
true:

arch/x86/kvm/vmx/vmx.c:214:8: error: ignoring attribute =E2=80=98section ("=
.data..ro_after_init")=E2=80=99
 because it conflicts with previous =E2=80=98section (".data..read_mostly")=
=E2=80=99 [-Werror=3Dattributes]
  214 | struct x86_pmu_lbr __ro_after_init vmx_lbr_caps;
      |        ^~~~~~~~~~~
In file included from arch/x86/kvm/vmx/vmx.h:14,
                 from arch/x86/kvm/vmx/hyperv.h:7,
                 from arch/x86/kvm/vmx/vmx.c:59:
arch/x86/kvm/vmx/pmu_intel.h:41:27: note: previous declaration here
   41 | extern struct x86_pmu_lbr vmx_lbr_caps __read_mostly;
      |                           ^~~~~~~~~~~~


So unless there's a wrinkle I'm missing, my preference would definitely be =
to
annotate the declarations as well.  More information is pretty much always =
going
to be better in this case.
