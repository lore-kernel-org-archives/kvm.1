Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731BA4756B8
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933089; cv=none; b=T21j0nf1h3hRB/tffZhWXL3hhqEBaQPnF+AvuFbzlYZGe94l1kGLpxHibgSN68AIZay1xhSW871PqjK8Wsx9G4H628OpPOwwIeKy0kea/SUbV1PhjoFdc4k6rbnVB7JX0U+Ebd3hIJeI/D47NcEeU4DlVvAAVl/fQXZJ070U2QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933089; c=relaxed/simple;
	bh=vD3k0UChVcsUPV8WCpzl60xjcOJJ7AH4O6Kwg/ASCvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mao8YbMXa//ueoplO6UohbRN4j0ZXgKQmnRFshbdUZbKn5ZTlPcPSj9LOEfAMjzvzMhKFSKrFzAx4l3LnV3G7LZ1EACBrkW+tgY+hC+X6s7oGTu+L/ej3vfssZnc7Acj0o8TzrurMlRcu6xsaXWz28rIWjZbIfroMDq3sxpdsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=RrlNGgY0; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RrlNGgY0"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aac9321so2006863d50.3
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 12:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933086; x=1790537886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xd0t5fQ0wbqovFneONezXRLopfuFSVDwWIsqSLQ6+6E=;
        b=RrlNGgY0iJCLHvLzaOqKkf3gLzRqZRNs3AAepRwIwDleyCYaiOghA4vqiXA6qubzC+
         24dvZefH6rJFbESqgiBexlht9k2P4jayHUVOxKavkv047Iwi3j68ZxrHzNYxx4AhE2Qb
         aKxGtjXjJX6+0Sgcy+nXo4muIMtbk+5iXSH83LreZrlNlj5brul3XvqxZuXYyMkJHbx2
         M9kE4SgGfjg/AgZJ+kZyRU2gcJRKIyvpm8ZE27VVSIw/faLLB90ylpqTLqx8w3sMAtH5
         fDGymuvYj2dE2L3f3IPD7SWIbaWLjxdGzXi9W7OVFRvoL20by8hHYOwrYpq+32pX2pRJ
         NpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933086; x=1790537886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Xd0t5fQ0wbqovFneONezXRLopfuFSVDwWIsqSLQ6+6E=;
        b=xhfWc9iNXAIDmLx4USskCgtg0wH6B0zcEc0Mapy/jMeAMtcxi1vXct3SBHE94o7U3B
         rE9ikgs5NU6VOi72R2CNYR0CyYL0ENEHUA86/Ku3C4E6XBsc9toDei17NHnjId90qJrE
         Ch5EV2aCEaX/NcEbvuVsCzl5bXRaQDL0IPYJlGEydkvu5WIgHYuEP7wm1iovuL5K4LWb
         HlrkxQl2n2owM0/+hAVwMZeeX5TUKTxBLtNzZ+hlVlHbG+/GnwXn0esRg1+8ZvEcPETF
         pkyalgmrfs1QXAbP7FPGZn0fUMGeVLXKh88KfZbcqwVe99QaBAu22rwWWEQ+q6u+XarR
         cZ+w==
X-Forwarded-Encrypted: i=1; AKwUvBxS0AFaqQaZDZsgG5woA7Xr9H1zB9GsegfJp8JiA+IsdoM2/alvTLqs7ayDFYdoF3XmWg0=@vger.kernel.org
X-Gm-Message-State: AFuF++k/P8RTA8KXh/d3JKaw6ql1NkMGHla50g/jmqwP/iKIGL4DfAFf
	fB7ryiRPt1XqwJGj1T0dKVM6w2O6XH0yyFPimyFJB/xaD7AQV1O3pxsoipAKKaT3suA=
X-Gm-Gg: AYBFou2tef16XPuKrk0UR39rBF9SR2xvgmOUcFQecGieXOVEeZuRRC9YaTDol1mZ9ui
	RHDDNv+CEKDajJKNOyRABqgsaALnIrpCDJESxBVyY2KUq3QxHqdRlyx9xfDDxVuGXeCMnvmHnzl
	dgk6eZQ5/yoEKGiMrrGJy716kk63S0QTM4L2sJpSHy2k7MpIxBYe5AqvkdUxeHVc8BlT5jHH9di
	7dCwRH7UbWBSaWeaVYP0gQJ52XL/vc0KBMckiN5yKI2SqSsTkOUR2J2Osp8BxV5TLMO0U5l4qGa
	GW8E8wDV3OHTxV6XYG3JiW0To1K0J6atxPh3hyUaOo1244elg9Oc5+c8luew/0KxATTRPYif74U
	rXZ2/ixQJJKH4sdDrL5jLXUfUIxK9HV1Rgid8tqywvVPyGnNHH8C9m3+jxci6ZLhPKdo+5JPl8J
	xv8PwgmoYksV4cZtdp/8E9DP98mnvgUCbCnBBOFQwgLjyGPbJwQXAmqfc9AQf8W0RRFhaWhU8As
	yrsz9qkSV+3pTemmppX2NapA/YELOPV3VrL5RvAAaLT0kcBdXcwGGu1o+chvVA5gcojec1U5j5r
	phc8Z0OGbr116k3l/38=
X-Received: by 2002:a05:690e:dce:b0:66f:c1be:a646 with SMTP id 956f58d0204a3-6717fd8f1ddmr2788927d50.56.1789933086522;
        Sun, 20 Sep 2026 12:38:06 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672991445desm2614214d50.20.2026.09.20.12.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:38:06 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 12/46] liveupdate: Add liveupdate_session_name() helper
Date: Sun, 20 Sep 2026 15:36:16 -0400
Message-ID: <20260920193650.3373435-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide an accessor function liveupdate_session_name() to retrieve the
name of a live update session from its session handle.

This allows kernel subsystems like CPU preservation to identify the
session managing preserved resources.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h      |  6 ++++++
 kernel/liveupdate/luo_session.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612c..119ad0f82705 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -256,6 +256,7 @@ int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
 /* Get a token for an outgoing file, or -ENOENT if file is not preserved */
 int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 				  struct file *file, u64 *tokenp);
+const char *liveupdate_session_name(struct liveupdate_session *s);
 
 #else /* CONFIG_LIVEUPDATE */
 
@@ -321,5 +322,10 @@ static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 	return -EOPNOTSUPP;
 }
 
+static inline const char *liveupdate_session_name(struct liveupdate_session *s)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..3c4f195d375d 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -683,3 +683,17 @@ int luo_session_serialize(void)
 
 	return err;
 }
+
+/**
+ * liveupdate_session_name - Get the name of a liveupdate session
+ * @s: Live update session pointer.
+ *
+ * Return: Pointer to session name string.
+ */
+const char *liveupdate_session_name(struct liveupdate_session *s)
+{
+	struct luo_session *session = (struct luo_session *)s;
+
+	return session->name;
+}
+EXPORT_SYMBOL_GPL(liveupdate_session_name);
-- 
2.55.0.1082.g2b9226bbc0-goog

