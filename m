Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB78433E81
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827339; cv=none; b=NB5U/AUIcInZqRtqehzmpx68ZOGhpvr3Ta34mIWXatzif+ggmzxW9MsrEWDabOcN34gnCWssw2xiRauL/lSwdagmNcZejLPTlwjNplK7VQHFz7wEI3CzZRoVQ7pcay5Sdhfk6vuMgmUkgVYi9JTBXCz/lzm7wnU71pKPAHLpU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827339; c=relaxed/simple;
	bh=isW5vzcH7hZFWP7TK939GnVWli1ArbFnfpqVb6Mi43U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/MNn8+3CfvzcZ5y9ScrxHytkNq7xSeeQ43AI+04pleUSXW6f3mepjjaZoqv+ghJKviR+5WmS0cOMsG2dM8TazHFx5bbLrA+ShtEW42VnMWpBf15awOxNV1014pvpJ6DjgWizC1tkEDsqz/TO/jwr/kmD+N4V84kk7VB/5rsTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKhdHfBW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFHQAJPg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKhdHfBW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFHQAJPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791827337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=62Jee7IyE5taDZZf4Cyq0DYOnCOUlmrnptCshY7ZnoI=;
	b=iKhdHfBWXpYMAPvfDqLc1ZEjWEmGkeeUw1ivyL7berCM5TxkfR1g60AYk9lU0ISKQKMNnF
	MtYuT1A13m9lbR5myzKis6bO1L8vkbauURzEx1wsL6Xgu7lz6ys/OwKa3NPnq/+vhpPG7p
	nb6dauVhdKORkk9amFlkBokmFyCxnn0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-mNvREAp9MhS3YCZ4JL6f8w-1; Mon, 12 Oct 2026 17:48:50 +0000
X-MC-Unique: mNvREAp9MhS3YCZ4JL6f8w-1
X-Mimecast-MFC-AGG-ID: mNvREAp9MhS3YCZ4JL6f8w_1791827329
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b028d93c5so1514350f8f.3
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791827329; x=1792432129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=62Jee7IyE5taDZZf4Cyq0DYOnCOUlmrnptCshY7ZnoI=;
        b=WFHQAJPgiZp1Jb5GBQxp8u4pl/utzA6frRdZ2SZEhd4ypdnamqEseFgVH+vA8zHLm4
         Cl+SX0j1qFvS09ZjCYzvZoQ0UcGziCkushlnisykN8YzmesBUjupmeFswu61Kzd4R7ae
         2BDBa6TXdfiCh8pQIGnuBTWjd4BkfQC7XxD92I8fZqUndNmvEu8O2BPNTYPVrS0aMnuu
         js/3zWVysSa9OTd8WmnqqX+uPuPh+wr5PvQFNiwQXpfT6B7E8fJz1i2W1M840DKFiJXF
         goXLWx7kWsfu0AVejQlSOkhK03jGxdYrs1av6Rj+jhEXb0ZjTv+OEzk7xRLbRhUioaFy
         hXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827329; x=1792432129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=62Jee7IyE5taDZZf4Cyq0DYOnCOUlmrnptCshY7ZnoI=;
        b=p7VSdMsf+PAB+S9eyYvNcP3qrpT6ESOK8ArcJtwCrP4fYaFGvgJH06HC0/vK5b0EXO
         8xSt16vRpIVVI7AtCS3vcXcpQofg0RBqgv1ILiev1HnFsnk7yCw6BOZWAEg2UGONi6lT
         luM7/jPodt4yjD+YV1qKEnCEDzHrQWIL1lzhnl6Q1aIp7EGp6AWdR/E2LqGiBxEoZAGc
         VIHWlJm25PjQVAY+CrLtVKGhRr/xfzMgdtiaxWSamulX1wcsxAEv7NDcvUmxP8B8A8Ri
         Q1p8PeCASEDQ88uarAouznv8xummC5xpEhgXp5UBC1DDioJRT30eQVGuORIm4Fr6Hack
         pNFg==
X-Forwarded-Encrypted: i=1; AKwUvByepFlUl0QH/TGz+6Ds2JqarPCOLXWtz48J2D2lJrGl72QSPIuo6MY7Z1wLhIoDqykY4vY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvlz6FcSVRZWlfG4Wj4Ie0+P4aLwzT9U3vJL6QLpjF5Lsasmxw
	oBuZbHU9VeuhZnE/b8cjYlqK2QrjP8KiDq/binaGBDzLEJCl89BGLj1CuuCxJ+7hbw9skZ3QJll
	D3nPoNpqlGWLh4NB2GIBBajGojnkgLxtEDJYUMGb7kBNBGc8chvui4g==
X-Gm-Gg: AYBFou1E/0OVG7X8R/CJ3zizV058Idp/LOgFppQI4MrEE4CctcuDT2WqHLSZJ3kfi6W
	I1ga8cp6mJWZpmAxwGjSoljbe2LCBv4F+U/JLOvwGCOMc6imatNP9AL0gJo3xyO+Kx4RcPER667
	AhEF5m0eYrQylQAUwLwAx7G2nEHVl8t9Ku8Mnn19dG+GhrQyvS80b8tjH2rkZyzxKsfvJM+cyAa
	ENMD8S1uiAguOrwVwiF21ZaeBlF+52Uu5qPs1YJgcF3DoDEDLknPJpBYfzssG0oOx5cCdOPkURO
	Rnp46+/zUF/pDmscsbzCPhuHo9ecZBoiotN6Vkme9BYV+FPhjuPBYqIqg1JTp3HjEEoNx4KTQsD
	PCeFtHxfirEmda96V/bNhd3+4cfO3l2jZj01t1sEX/JhFZjF8Wk+hmfoIoRyqOCXjhIuP2HX9Yp
	QYa1sN
X-Received: by 2002:a5d:56c3:0:b0:486:f97b:6412 with SMTP id ffacd0b85a97d-48dbaceb3c2mr14753108f8f.46.1791827328830;
        Mon, 12 Oct 2026 10:48:48 -0700 (PDT)
X-Received: by 2002:a5d:56c3:0:b0:486:f97b:6412 with SMTP id ffacd0b85a97d-48dbaceb3c2mr14753075f8f.46.1791827328306;
        Mon, 12 Oct 2026 10:48:48 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4edfsm717714f8f.26.2026.10.12.10.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:48:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seiden@linux.ibm.com
Subject: [PATCH] KVM: uapi: remove dead #defines
Date: Mon, 12 Oct 2026 19:48:47 +0200
Message-ID: <20261012174847.147915-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These #defines were used for the old KVM-specific device assignment
and have had no in-tree use for more than 10 years.  Drop them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/uapi/asm/kvm.h       | 2 --
 tools/arch/x86/include/uapi/asm/kvm.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 56d3fd7eab44..18c3ab8b0764 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -45,9 +45,7 @@
 #define __KVM_HAVE_PIT
 #define __KVM_HAVE_IOAPIC
 #define __KVM_HAVE_IRQ_LINE
-#define __KVM_HAVE_MSI
 #define __KVM_HAVE_USER_NMI
-#define __KVM_HAVE_MSIX
 #define __KVM_HAVE_MCE
 #define __KVM_HAVE_PIT_STATE2
 #define __KVM_HAVE_XEN_HVM
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 1585ec804066..00ce265391e1 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -45,9 +45,7 @@
 #define __KVM_HAVE_PIT
 #define __KVM_HAVE_IOAPIC
 #define __KVM_HAVE_IRQ_LINE
-#define __KVM_HAVE_MSI
 #define __KVM_HAVE_USER_NMI
-#define __KVM_HAVE_MSIX
 #define __KVM_HAVE_MCE
 #define __KVM_HAVE_PIT_STATE2
 #define __KVM_HAVE_XEN_HVM
-- 
2.55.0

