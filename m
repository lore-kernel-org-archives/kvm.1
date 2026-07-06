Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4E40A956
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342457; cv=none; b=kZra8ziGcU4jscDHQPRbTJQSYw159Xv4iOgc35/6blIliuLJnjrvrAvsuFv6bgmeV0RLPEcvb8eOJQRemTZDyIs/PoJodJPaLn7xAxNEJN1prMvg6ScPwnNNuUWg3qhrZgyx14n7LFllouDPf7FWcHM+9jRd9VLhQeigGcIEm2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342457; c=relaxed/simple;
	bh=Kjaz1rel2sNl+d5VT2IglyjxLokjkl6yFaJ2/HKSzoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsWgYWsFWM2bwcfXiP+/gvTIiv2VPzz2/GOqOKrH1gDmuk5S47okf961rSyPwKZ/IaRV2GfnTe8YIPYBiqJuZr8OTty10h6ri5jyMBsDvbwEuH3MhHKD5hReWRyMOCvV7vIBF8cNJEMR9oIryeuFKRZvePJuFEewhUDnAZRaTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vob6aftr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vob6aftr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783342455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnMduQI4JzxWh7DFwl+Ge03blT1Jvh4bKa8/9Kbe0yI=;
	b=Vob6aftriR0uk832onkM5IfqxbMzv32+jxYBaEPB+VnX5JQCE9HcqnQpazwR/vn94W7FFA
	9EImZGUtFl0yjgXDk+r1HoRTq88hXJXd/5mr+RPAWh+/xvcFNKGJdniw22zvKgbI86enP7
	nDsxWZ4cxCypbfuG/dD/Zcgnig9S6ZM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-jJdAaHZJPySxLGTV_LBjCQ-1; Mon,
 06 Jul 2026 08:54:12 -0400
X-MC-Unique: jJdAaHZJPySxLGTV_LBjCQ-1
X-Mimecast-MFC-AGG-ID: jJdAaHZJPySxLGTV_LBjCQ_1783342451
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3072118052F9;
	Mon,  6 Jul 2026 12:54:11 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1169836512;
	Mon,  6 Jul 2026 12:54:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 06 Jul 2026 16:53:48 +0400
Subject: [PATCH 1/5] i386/tdx: fix uninitialized variable warning in
 tdx_check_features
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix-v1-1-4b83a70e9f3b@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
In-Reply-To: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=902;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Kjaz1rel2sNl+d5VT2IglyjxLokjkl6yFaJ2/HKSzoY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqS6VnYhFFHkp+YuIdTnf12RCW5HTzJn2F8kIu0
 UerFQ6AQPeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakulZwAKCRDa6OEJdZac
 5XD3EACUpaHxCQl9UJsJGOh2BXvqFVl6jDj38+2BJRXkR90lAoyWnP1ovKmRtnOQM3/7mDXAaod
 lsJS4vGb1Y7Y8xF2l7IyfOmaVedA35VA2nggnoDwJVbJzALyvcDBtHuBvIpcs6Hd1vJl+6fANUi
 IDU1ovdjpHn39BlS4M5VjucnumTy5pfC2UZz1mi+sAy9Oijr31OX7bIB/7N28/AEdMBpjacFid/
 YmLaA5Sch7P2AZzy3muspPSf4919k2nPABU4xvM3Fr5nKnYX7wa3GSf4SrpnOyGxTzHELAmqf0O
 ltlqDrdo/XevIXh1TkIAZzfhNVMiQDBVkWqo7e0ZqQnbs4a3G2gnch3hNrnfZtYi19KGOI6/tpG
 BLNxvvIqWtGlMlOXoPx+3lNrb/Bjy9wsuHg/GGnlvXzp/LUzcKw7HffIuBKT/8N/x71Bdw96Zzb
 LwzSZgvZj5B39lsb+TYPdoptEJJ02B2+rg/BCa0MAGPLags8qN5DVK/QexYoRw88ybl2o98MT78
 Wc/kK8GdmX0DNnE9CqnXdDNZcSApCz6Fo8aHV7FNb6yf29dHecnd+dp2fMjKu6ZM+iLkH6dqPr/
 kLko9KTWZnCGFN0RDMNeYRuxE3NoivcSlE5vKRAkkvu+hbYvnz7Npb19dwPdGFgWT6FyY9+kdjA
 Yi9b0qmwuvYoyww==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

tdx_fetch_cpuid() only sets the output ret parameter on the error
path. GCC cannot prove that r is always initialized before use in
the caller, triggering -Werror=maybe-uninitialized.

Initialize r to -1 to silence the warning.

Fixes: 228e40f33048 ("i386/tdx: Fetch and validate CPUID of TD guest")
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 target/i386/kvm/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index c9c3b05d5fe..8294dbde3aa 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -887,7 +887,7 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
     FeatureWordInfo *wi;
     FeatureWord w;
     bool mismatch = false;
-    int r;
+    int r = -1;
 
     fetch_cpuid = tdx_fetch_cpuid(cs, &r);
     if (!fetch_cpuid) {

-- 
2.55.0

