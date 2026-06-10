Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12473955EB
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078701; cv=none; b=p2dJCEbIRNLMStv1GDZh6I6z/CoJB3/lWyuhAQ9sEcQOlSTfw0gY/c66lXx5UFoXWuhBVtiGNlMDW5KlfryWdRt6pUubbVdgmhEFevyd2M2LSU11o/RMID3RVfO5O/NHh9HUGRaMhgYtavFwYilnHrl0Noo0SAmWu6xyRu0yVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078701; c=relaxed/simple;
	bh=+meFXvAaft6w/bB6VAVCJt2x8wbotjPd019FZOlwMVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBKdhJyrhCnrG/MwEiEvhXHmVJnWtB4ChY5ysNZ4erJhse7OOKnVopOKNkeII6r9l76s1Xfb0ciESTVUbWrtAu7PX0tY/auTJFkPdw225cZYYPTY9S+rP5+7srXqUSRA/Pq5k8cVjkwWvKBS4IW0k8VBu2ZLbYW6LbFjgHQUwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFz9LiwS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFz9LiwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781078698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWE2nyb+C8G/FE6PTAS3ec7qSrpBu6hTUMnuaWUCrN4=;
	b=NFz9LiwScNg1YT3RiqyX/GsXNABGVl8Wz/x/rt2Z1TllvW8niXBdMFi7zv9SordRZ65pjO
	bgG7q82LRLrJCmXaTdnqbLuJVvXxcjVyNAYKcnwEQM48RIh7yDvvMOmuRXrkRRGjumkDDd
	TOEhODMEJ6DRgfTic08M+prA75ScCwg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-BiGkoJmJOkmkjDrpmuUbOQ-1; Wed,
 10 Jun 2026 04:04:54 -0400
X-MC-Unique: BiGkoJmJOkmkjDrpmuUbOQ-1
X-Mimecast-MFC-AGG-ID: BiGkoJmJOkmkjDrpmuUbOQ_1781078693
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2A251955F44;
	Wed, 10 Jun 2026 08:04:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A018195410A;
	Wed, 10 Jun 2026 08:04:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B2F6121E6A25; Wed, 10 Jun 2026 10:04:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 09/42] MAINTAINERS: Drop stale F: from "Overall KVM CPUs"
Date: Wed, 10 Jun 2026 10:04:14 +0200
Message-ID: <20260610080447.1156502-10-armbru@redhat.com>
In-Reply-To: <20260610080447.1156502-1-armbru@redhat.com>
References: <20260610080447.1156502-1-armbru@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We neglected to update MAINTAINERS when we moved the only file out of
include/hw/kvm/.  Its new location is covered by "X86 TCG CPUs".  Drop
the stale line.

Fixes: a09ef8ff0a (hw/i386: Rename 'hw/kvm/clock.h' -> 'hw/i386/kvm/clock.h', 2023-06-20)
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260603064032.3733394-6-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04eb81298c..14ac72abd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -471,7 +471,6 @@ S: Supported
 F: */*/kvm*
 F: accel/kvm/
 F: accel/stubs/kvm-stub.c
-F: include/hw/kvm/
 F: include/system/kvm*.h
 F: scripts/kvm/kvm_flightrecorder
 
-- 
2.54.0

