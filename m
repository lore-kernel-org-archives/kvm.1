Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127AF3E717A
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097007; cv=none; b=tGkqseO5bIf1PdcQDUv0YNK+V4FppVmHPvJWNLV2s15t1qlHvjFM0nevzA4KbBMc0IyvTy/WYEvOxiG00tevHujvTpgSs7vHzFYZG2jW38lsmXCNw6RqkjZXBbI9pZuoWMrPi0MTIaFZQbipTJCJXoHoLLEYoPcbQDHHR9uLXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097007; c=relaxed/simple;
	bh=Z0VMlnKWrIbM8ucdcV8fo/9qaRMgskvqDrKATZ6/SUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tEdPNc+4B3yJNCpHji+Y5Af/xpfjv9MPJNtrA9+yAj9tjnTHjnhbrbbnNIFvqDKmRZ84T9uV+s0vHf6wqLsOyLSCJ5Q18uTTESIBpm3vqzmXdB9TYdpw62CBJflqMUDWY0jwuZ/9d9FlbRpE4k+EjGFx6gbn5UbXUwSiDMdC/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dk1plU++; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dk1plU++"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48fe3e73da6so9037755e9.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097004; x=1779701804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jv7htWRaexdWX7r0/O/5aQjJsBEQgyvtoCI5ugM9CJs=;
        b=Dk1plU++yg4+P+u+713qMALJiIGcGGrMwdrvNKZwMdgdf2XNSk1rXhGQI3TAswtCu6
         dHw00ioXI/vlXvkfRl7GuUQ1AJvWgVDqzyPW4Q+563mK3pMvoOWKwu1oxJ3YkuQYnJV4
         bCH4Xwg2HeWVdags8blT0bdiPamK4xvA/BHw9IGXKp9seV45pILXJiIn3eLp/Z9SCYpf
         I+ZVTy6BkwLjzKKJ+GWPmLA1XBRYOEN2aemMYTRPf0QN3ZYwuK43n5CrNxbLY4CiKiE/
         lWM44OT3g1DwAgDiVKRl0dkveV/qg1qXdNTKzBxrA0dPtq7ULW7j2Fy9C7gJBMkSTKZj
         hOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097004; x=1779701804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jv7htWRaexdWX7r0/O/5aQjJsBEQgyvtoCI5ugM9CJs=;
        b=VE1U2xR9JWPZo1bd0GUop0VPMmLB+kK9GCAErr+0b3zb+fnxIY2J2N710h8qGrUTuh
         ilreKZFJNogCq+oVIv+EBznkiw1IbzGJtPA0Q4vI5QjtpUvuilqHpmuoTrYvS8dg7pOj
         gYVG0a2sXK8EjXbQZaXFpplpfsiYdxvd2W+feqPsgFYGUC4u5+BB8feH0M+gJyHAdOnr
         tDA5w2K2SfLA9A5mQddJjPLXX7i0pzbSYJTnGEAZuiv5cCFxMhwgzx5ywH2HyF+RnIvK
         TGJR2GDJuYEJjzAN0xKgUUDqNWRpyJqz6dCg7LX3XlesuSKUQ4jiadRYMH8EeQkCyWCQ
         COpg==
X-Forwarded-Encrypted: i=1; AFNElJ8GH+pjj8EeN4i9TngIAea8CZFMzNbPxV1GoYwaCA5oRKW69+htIkVqEAorbvkK/WsXffs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxndSUZdEsOyUantYUJmiMnYPe9A6IlbpwCML1jYEoqX2E6l76p
	X5qkYmZ59x0FvZZX5zgn91jcIBif/jrtCyjK/JVvXSBn5u6NdZmkdl7U4GEpBiamslGPtVLmshF
	dx8KW39iZvQhCFXJO1w==
X-Received: from wrmj10.prod.google.com ([2002:adf:e50a:0:b0:44c:111d:990b])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b6e:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48fe61ed21amr229120015e9.20.1779097004324;
 Mon, 18 May 2026 02:36:44 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:32 +0000
In-Reply-To: <cover.1779080766.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <63776195da42f3307cfa0ad9ee7aa5504e4c2cb1.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 2/9] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
From: Tarun Sahu <tarunsahu@google.com>
To: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, ackerleytng@google.com, corbet@lwn.net, 
	dmatlack@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
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
2.54.0.563.g4f69b47b94-goog

