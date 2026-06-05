Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7A386568
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679328; cv=none; b=ep1fLhwmSOYZ3UFxhc6dq1Mp1PTQnzB+MXWzehW6jd37ow279v1IxHr57cHy+xSX7ilRtHmpnqZM5qY9bTpYmYIoa4FqdgiZyCLjb410/fhsoqw2o/f9uGVBMvyZae+ZxgkZ+sXmeWq9JTuvJa9uROes8jrpn6U6bEXTMGXm8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679328; c=relaxed/simple;
	bh=eteoMHJ7Mk3s+G+vf25Of59vs7CpFhPIpMWB+6c3DaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tSYsMzabyB5qntI7hh/ZTNvHkm/ZV0LzDhJJQkx2FWmraUTqErJpOx7Y/XHCbqX+yWYDsao2eqTsTWooM7RHN6InvRjOvOABXhBpJrznih1xZOEgLPmnD+2DveOBkCh4577uVn4RhVrNaf7jhUxEz1cPt73dfbkb4oF+t4tdOFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i4E5Wbfv; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4E5Wbfv"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bf4ba05fd18so1292766b.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780679325; x=1781284125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUNSpB3dfOvSGnAPr0UW6nHYEMpqSvyWhzAeEo+qvXw=;
        b=i4E5WbfvKesxwDViJZDAzLwOfomdVLEu2LiVDcXtbSvYJtQWuyMcs8zx3CqK79/umf
         vCwASa6KEfVnvWWNGF8JMaxKSWFNTfWSroeR26lbYL8OOTW1/iXYHPUKbmhaUZfg2PdO
         lPrTUA0AF8gEAvUn1E5E12Ol1cmeqzAUESZExP8dN29f9F5Snk4iwk1awmgmsg84I9oh
         DEPrjZ3n5a8JCg94e71plB3A0rb3tqFucFL/q0D0xZo4voWNaCMbYFzvcU1FKsetSboB
         NaNWPv++Fu1VBpQICxG7YhvXTZPLjCpeJjVWSUIUigxXhxvAXd8QvHZr68jhmEh/Fpwi
         ruSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679325; x=1781284125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUNSpB3dfOvSGnAPr0UW6nHYEMpqSvyWhzAeEo+qvXw=;
        b=DMUdQ5gb4CjPaP+l34R/sPjcaUEJYa0clHf/yY3N1/aFhBqjDQgpuS51eRyAwTk3bF
         ptepW9E/i1/l8ov72jhxLR10K9ghj2Vp4by+DpvWvCsmx5pFCylMfPKSb+OHpb0oigYz
         pybxS7mMKdzCVJ9RohOvH0SWOomVrYVZJFXHZRSDFSmmK4hOWowEpGwaNUDZfo/68Kmj
         ef9uUhQBZUG7fMTkB9eR5MazEWq6omX5ibZkq61aq/pEWL8UU/uBBMSFI+J9vnbqy0C0
         e3LW+TcgBaUXQyVKp3jBVtiEAX++3ozAE7Ae4/wPxCxnRvuFznfDg3d35Ym69nqVgufx
         Q6Lw==
X-Forwarded-Encrypted: i=1; AFNElJ/5bHE+QQteLEOFlg44bvo3dXLVJvrYmcxPKemB5Rl3U9TrUup6BJWLAgTUMHV67JWFFl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGkYLstKpB7StTXaY4jIQQh5WQTMNUTXM2fKgJ7zu/N+GHUp63
	h0mzDeeEKSkibNn2mF81z7TxXv+xF1VUQpZfvBbcAc7MC3i5z0+jm56p3wR+bBaC7XVQZoLhHg4
	ogcZrKnkcOzA8N7kBQw==
X-Received: from ejbzc9.prod.google.com ([2002:a17:906:9889:b0:bc1:3569:5260])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9812:b0:bec:18d5:ddec with SMTP id a640c23a62f3a-bf37311392cmr242121166b.41.1780679323496;
 Fri, 05 Jun 2026 10:08:43 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:08:27 +0000
In-Reply-To: <cover.1780676742.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <c17394cb12c805a7026047beda2563c7bad44a61.1780676742.git.tarunsahu@google.com>
Subject: [RFC PATCH v2 02/10] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	Tarun Sahu <tarunsahu@google.com>, fvdl@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, 
	aneesh.kumar@kernel.org, skhawaja@google.com, vipinsh@google.com, 
	ackerleytng@google.com, Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, 
	dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Introduce the LIVEUPDATE_GUEST_MEMFD Kconfig option. This option
enables live update support for KVM guest_memfd files, enabling
guest_memfd-backed memory preservation across kernel upgrades.

Currently this support only guest_memfd files that are full-shared
and pre-faulted.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 kernel/liveupdate/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 1a8513f16ef7..0bbc4037192e 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -88,4 +88,19 @@ config LIVEUPDATE_MEMFD
 
 	  If unsure, say N.
 
+config LIVEUPDATE_GUEST_MEMFD
+	bool "Live update support for guest_memfd"
+	depends on LIVEUPDATE
+	depends on KVM_GUEST_MEMFD
+	default LIVEUPDATE
+	help
+	  Enable live update support for KVM guest_memfd files. This allows
+	  preserving VM Memory backed by guest_memfd file across kernel live
+	  updates.
+
+	  This can only be used for the guest_memfd that are fully-shared
+	  and pre-faulted.
+
+	  If unsure, say N.
+
 endmenu
-- 
2.54.0.1032.g2f8565e1d1-goog

