Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409394;
	b=tk2wyENY0fZAnjZy7/TBvJVChfw6tyU67Inl3ZtXPCHZAHyPncm4oS37UkNwFGSH3bVP
	 1go52agSrMoiXS1jHn6A5wVcG/R1OP7l+OFnmabzDIGwpz1FaJEuzMEWuxV8gTYvFyuTK
	 FMR+fEPTTBmlTA8iQ4a7tQE+K6FKSmjy7pM5QzbHSQBdS7PqsfhrARtgZ66z78yGNsO5w
	 wbkJ0Os8clilrqBNBDDnuEjDUZPDccCXJ6pem3YnNJckXQB6UBkDHTC9fAV8X+ECcXF45
	 8VJq7aYnPpvnh0KiJ46ehmOd+BXex9x4x7FIecVwX2cosECXaQbZ9kmKYFPp56hr2bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QJ9P3eG42e4bDinmt+GHSW0t1NFwPEsKAAiRCi2d2wo=;
	b=k0vN2CBi6eYrcfOpF4uJGB3ANKxVh7K/xYmA0YLriWh6bg4/5eGlATxpvz6ipCyeD57/
	 lDHjcMmiDXOf9wVAX2kYtZwXQCKiV0VRNbNtufjTir9hTXpZcWnpclXgjAs8QlE07t213
	 DaL1hoibtGfGnhztNTI7ZjjtpudfWTqsjHBj7c9q5h5c7yzFwsiDtbvYU4ZVkZICHDvaS
	 JrcDkPS4X3Dg3ZBSC4SZg2R8EElDmgdPmC2f7xJIYZIFveTJQEMlVtquyUhVYUGXQYtF6
	 zbVvR/2tRJ4KyL7aXViJrAMMrshcXNyJgAAqLtRK2ypSdPbbO+JaMT2Ayp4RpCEs8Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k52RuMtG;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2D606A327
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 04:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC2D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k52RuMtG
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b42c3dba96so3366731a91.1
        for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 20:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409393; x=1796014193; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJ9P3eG42e4bDinmt+GHSW0t1NFwPEsKAAiRCi2d2wo=;
        b=k52RuMtGOXwNVtTmluTuWdrz6HmzziKPCyIga+m7O3whF1QnqUZRGmrAa+0F0B6Pm2
         FVkvvhPumgcU12nLVJJs37zbtLKW9wxEV7VECjCN37qE5q6LzABgdZpFXXiJluqLyIfZ
         c2bTvvHDWdIocpDUGAnlFdCRpnEDvb5k91unxQWpETjtcr9CK7Ar4B5JMEgewbhMO4RW
         zFkbWMFnkokstuzkWg4cmsG2N+x/Q0anqfA76S0WFvTgLSI6c2PmhYKzMukIsHN4Y8fd
         PI3WRkQD57MgOs3AMT0aoyAVNABcjleqOnODzsIgr5L5WlFkJ5JJib+CskmxYiccThdf
         ql7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409393; x=1796014193;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJ9P3eG42e4bDinmt+GHSW0t1NFwPEsKAAiRCi2d2wo=;
        b=hNQLoN2T5X5MORfz3COljF5cO9DQr5TdzyKoAPpRkIH1qIsR2owtIaBKXcv1DMT/bW
         RyFBDbukNN90RC63Auh5iagdmYR24/Pd6FtysFD3aN0shaiZIAEvHK3rGmybQtUq0R3i
         q3ELKdDvyXgpAYVy94kDxCm34YMs+VjeXQXATdl56aMSVNM3BIyuBWybYTz/BQgMQkOr
         iFpWiqC1nw6RUwluTt8fBbCqBiyzEbAaDO+rjUbjgcOmwQvDj3vFwVcvUvfCG/EOo/q/
         AvkS/moz6xPMHPkgdK74HQ0Necec0LHQYqBBWk/i4Kh4cdiy5kINQhz82084b/Ek3e+j
         ++NQ==
X-Forwarded-Encrypted: i=1; AL+hErFp7QFBTp2buuNb5yy7XFdWENeBwy28fGEizMm8KRZ4HiYiKkZy7uEXcNH1on05Ec0cV7Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zVe60DJL+OSoQ7YcPvH9BmwOKbdBFscWK+bv9Qny793AHMfDS
	UixrdpHM5eNiwXQU2oO0iXo4OXksLltlPZAJABZe0ThjwqHc9nYifcrCiMFRNJ6iDg9xdFdJMSk
	wFpNpbsI5Gfx7tw==
X-Received: from pjbgc18.prod.google.com ([2002:a17:90b:3112:b0:3b4:1ec8:4e4d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b:b0:3ab:e588:c2a8 with SMTP id 98e67ed59e1d1-3b41c9ba0e4mr8778659a91.64.1795409392721;
 Sun, 22 Nov 2026 20:49:52 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:32 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-2-skhawaja@google.com>
Subject: [PATCH v8 01/18] liveupdate: Export symbols needed by modules
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Vipin Sharma <vipinsh@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, David Matlack <dmatlack@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Export liveupdate_register_file_handler() and
liveupdate_unregister_file_handler() so live update file handlers can
be registered from modules. iommufd uses them in a subsequent commit,
and it can be built as a module.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
[skhawaja: reworded the commit message for iommufd]
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/liveupdate/luo_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a39992da504f..dac7a1c4590d 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -931,6 +931,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 	up_write(&luo_register_rwlock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
 
 /**
  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
@@ -948,6 +949,7 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	luo_flb_unregister_all(fh);
 	list_del(&ACCESS_PRIVATE(fh, list));
 }
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
 
 /**
  * liveupdate_get_token_outgoing - Get the token for a preserved file.
-- 
2.56.1.809.ga0b61035b5-goog

