Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263492;
	b=MeYQbIMidDyL5fPotGWYjuXOcQS46nGLUZbkJfaBIKuJK3aBChoe96KwbNhImDpDHjmg
	 OIW95q98OUCQd9aHGmDxIC7NsdFdf3ZgQc0CascTk56U3JqAYnHq4EBfsWlcgSyZvoMSg
	 MiqJbkgdO7slMrrjhGEoyKTm1AUjm4ArUuc9VoWazIwq4B09EbZA6oULsQqrJPD0jPR8s
	 xpdp9bdBwnAltMFxerW7sti2/oPXDfa1djpVTuCUqF0EL8P/pu/5vDPP8DZdWRjbkGKU6
	 3Iy4x0lrv79IhMG1o2huAq+b62qSa/aplG5lUbj86HxEYFIk2G/Q2hpQsJzaQshRVlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dpKkV3dUzsFB7q79rXzQWVH/sr/9fyjU2C+7DXlAe6I=;
	b=C1JAlK7mZ/QXW1TLL+HTVoomaF8+CUmnWz7//ox8iXunzewNNjxeEItAVV8I16QGYYkm
	 vFPn2nkFsTuvz1hR0S9Asie0G6zPMjwjDpA3SWDdHEbR/HcFRLjQg7j9K3YaJlFl1awwQ
	 giZCDVraMZBwjwmJpqgDttQ4J8EzGfZ2EzEdZa08RwqTRWTrmqzj8K7ZicqxKn9E6Zd5E
	 HG0ihDCqI2KeVM2YX7f9Mq7biQq79HYswp0iflS10D6YdE3pmG4dpuccLPeP9f5lSAFf3
	 DY+AglvEOhliXzO8fknIr5zJKbqmgz5OdDaHW4huZVDiILQH4AXSyfvXoihdBJzfRCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZDY7bbQv;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB6606A335
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91CB6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZDY7bbQv
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-886e61fa30fso588453b3a.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263491; x=1794868291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dpKkV3dUzsFB7q79rXzQWVH/sr/9fyjU2C+7DXlAe6I=;
        b=ZDY7bbQvdJckR8l2xLpkq3TJKEupmUTTiA3wJ567AWG5DtLyY/DFaZIPwYBxnMkCCi
         Lat9FRIsOL3wbTuMq15Pk9LkcHpaTsQ6HLa9O6n8ozqSbFhWQMDW3LsVv2WPCPPBpvrv
         pvUn1tmjLdKjgztGdOfBSvxNiR3jDlCnbvekeswxQ/gbt24cpfBnYYSAsaLCe0tB4WjE
         NeydYVGpQD846x6SvxhmVbGDOCIjP/b5/Ag8tzOlLprDdfhuqwu7dxKzdG7aZQF9xsW1
         enWyh2plSzpLiBqX+o12WtDjKclTGr73bwGBPEVakOuxsa/Vl7E/pZIu57xqIKhubV8a
         wKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263491; x=1794868291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dpKkV3dUzsFB7q79rXzQWVH/sr/9fyjU2C+7DXlAe6I=;
        b=FhzECwfhZjedUgtaIIUExQTQx2ZYaY+4d+YUBj7IzWjfDwNpcu8vVxUbReYGFkFKVc
         +z29DzE03iuQxT5QgOw/N5qycT4y3t2ExYqtRyOg64Qo5f8b8RKEySeuB9+xC2DkiHBc
         9ZIQSWb23nUo9WqT0qKBSEYHiLUSs4L9SYDdq1KHG+JegSffsD5S9jctN+Dxs2lcDNeE
         LUi/kvqSv4tjqugUYRGyT+kaAnYUShfcGaMeFpyG9aQRXpfOi/ghOZ5PGS8Sf4/CX70O
         s7+0rQEY/m22/NC279JemJ2YVJo10ytxbgDuMk6iBkOSHf48Jc7zIOQEia/wn+ObvOMy
         B0Qw==
X-Forwarded-Encrypted: i=1; AL+hErGn5jjQkEPN/f6KMMY05ZrbiqBSpZZS043MCIEI9DibJau6dpsVGkFWqgxdQaaiYT43UWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FgXqLOUP6+AygRy4toW5dgtSPqvEF4163w/5TWCNBE5xcWwQk
	OotLbLHTcy7S/cQkQLDp3SfHmbzpAJSs6OJVbabOVgYrRVkaqSzaDbqNyb6sQeGWa+Y=
X-Gm-Gg: AYBFou1IGnVcHczoueQOlxEn1lObbeIAp63TeJJiUU9AHIPcVQtR4qfVHHzBA8N7r3c
	NEENT5U6IXpbvx0lwN1kS6aYMmdxYeZe/JVSq1QZHokjUV/eWY2t0xwHdOZ/U7aP11UF2zSG50c
	TcfJrdLto9LfIULI0CGI4MJ14l1j4OIn1Ce2q5oDLucj8MyHGyI+WYuGpFgR3/WWlJRD6Ut3OaX
	46K71OcMPUNMxyHFmgLu9vmZk52L7Ra0axXlhqPKvLvLJFZKFnS8fChmVGScDLJReuM7W8LUNPj
	aXN8d/uBXg+ruVtoGGh7Ldp3NAhTFCH7DxXi8riodKjp4ooPtwldD44kQratArtr86FcKc/zwak
	aWhRV6GkQLCyI52fpVidfAQQ+QU3esWcRYqMHnd8gbDCUr0enJEeZOcE5z6aacG57jbzcOQLFcK
	Oe3qFkzqo9Ry3cGgxzS9Wau9S6GxwRIt5KQ00JGk3oCr2YPaJ+4CDbMaM03ErzqYclBlf/0ymZi
	+/kbwGcXfqnGCX87ulYK83h40E5bUpI+XZjUG85hcJhLrNRvo4vi+i6GHtygipalj6gWexrjyVn
	2fkIrK2ng1NxSYsOAbP3lYXo0Q/Zv1U4jFlBThrFqnGxfrNL2VX88fEe8lvwDTNyciu71UmMi8Y
	=
X-Received: by 2002:a05:6a00:3c87:b0:87c:f67f:f7d3 with SMTP id d2e1a72fcca58-8ba82773107mr899316b3a.0.1794263490880;
        Mon, 09 Nov 2026 14:31:30 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:30 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 08/23] target/arm/kvm: Add support for PSCI 0.2 to 'features' flag
Date: Mon,  9 Nov 2026 16:30:55 -0600
Message-ID: <20261109223110.1619504-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>

Starting with kernel 7.4, hosts initialing a confidential VM are
required to support the KVM_CAP_ARM_PSCI_0_2 extension.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index dc1004785cb0..80296e0a867c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -390,6 +390,14 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf, Error **errp
         features |= 1ULL << ARM_FEATURE_PMU;
     }
 
+    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
+        /*
+         * Versions >= v0.2 are backward compatible with v0.2
+         * omit the feature flag for v0.1 .
+         */
+        init.features[0] |= 1 << KVM_ARM_VCPU_PSCI_0_2;
+    }
+
     if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init, errp)) {
         return;
     }
-- 
2.53.0

