Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A4347515
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154144; cv=none; b=s+g2WZiDZZRrmb9MhlW4WJ621AjmyKafVQlevSiDuUun1Zz/8/cbMyOj4REuCEVuCat1trdsAnIPprbRyMendjMvNM3d99cxnUODUYRALfiwkW5n5DgviUOKLFb53PraPr30b+VKD5Ows3Ow7bhwAFl6oyEj5p+8TuByxKR6ycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154144; c=relaxed/simple;
	bh=/ll0ethd+Y+ejhMqnBHdeN5CKETZ/XI2FbZX/MXGx/Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MV8krJGNNvz/buwxBmZpqjFpeUvySDOCmDSfSM0O4ux+1FZaomM3Gwv0AxdSm/CdKRgIahsBaDdoVGwFzz1bbfC+asF7JiQTvgidxfhE3y/unAtqBneebr/gv7B8l0UqRufkyuGXEY8cFKrXaG+KCDRURwgNyxj0BhTpcncs3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWnEmNUW; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWnEmNUW"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6973d186db0so2914863a12.2
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154142; x=1782758942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NnqtfMpo6SzkdI4Y/HSdjjWo3N5TymmoO6c1c+A8Gw=;
        b=lWnEmNUWgiAJuCJ2psJandvmHOGoljVXEmEv3OYvw0DxJprLApw1qjEYX09tdZRrhX
         oUJ24G+STJzQ9IKjsXcX/JbP35nXiyq/igPt8ZrYY5xjK4T083/Z+uU+vArbD1e4ZLPj
         kqjjLTD+pIZQb6fvbRiI5DGMRhxL3gdvAqu5KsHpFhdJhbttdal2xMNMccXTK+Nnj6Aa
         IhplV7KRdWlu3elvPgyiz8fBwedc83mISwlZ5/YoGlSHiXgSqv0BSQxym96tDcSjObay
         /gm3KfITuRGwTY7SKcyHQqN7FKS9SINMc1GvgOfUrGvdTnCACxEiaWQ15STUAeh7CJev
         mQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154142; x=1782758942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NnqtfMpo6SzkdI4Y/HSdjjWo3N5TymmoO6c1c+A8Gw=;
        b=FcOb1d1B6E0B9a3iTg9CBjpDw2H5wcFcbyXLYO+GxJ8Xuk8xp6KuauIsY/oX+wKTh1
         XN8w9Jo67CQROC/6AXZ6GUTBVY+/DBrbvSLieVo8WLPyA8XftTGsarq8QWYZC1uSFPfA
         IhrzLV9V42nHIWZrmdChy1hE3H+ZMjxh6DFsqm3yY4oLj229L5EvvlXy6hbOqS2RkAuM
         7R4t0Pm2mqWTFTZD44VaabTWqiP3b3JTF8aHMBGf2V5LAdOlINDPCp6rLlmpEoYXPIIz
         ZGe7VU9q9EkzsYCSeYo8ImUsm1nRsH+7b8HFtVz6tMpV4ZVjz9K2OR3Lf8MHmRXz3GLt
         D7LA==
X-Gm-Message-State: AOJu0Yz1Tgiu2vEYogNTEEjkQywOGbBUV7C5Sm/uKUFKO5TWSHq3CnCF
	UTZ3muyqblGDJHm2JSKRRtyohXwajkZf6gthpb+er+ZVYUJWNoZnCxXAlEMJR2LUv1UAmlIsitm
	G17qQdYYtugmL5sv1Fg==
X-Received: from edh3.prod.google.com ([2002:a05:6402:5043:b0:697:8dab:813a])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3548:b0:695:837d:529f with SMTP id 4fb4d7f45d1cf-696e5221662mr7941415a12.20.1782154141503;
 Mon, 22 Jun 2026 11:49:01 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:43 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-2-tarunsahu@google.com>
Subject: [PATCH v3 1/9] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
index c13af38..2490f9a 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -86,4 +86,19 @@ config LIVEUPDATE_MEMFD
 
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
2.55.0.rc0.786.g65d90a0328-goog

