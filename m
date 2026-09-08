Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10637F8C7
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846714; cv=none; b=g0hJ5wsSYAD/52rFSS321CXyMmya1i+YAsiWfBZIEYua80YZLSRAfKS/Bl7+nbN/NSYnbZOQYYJ2rfrOYxUnT8SvVseecbHJvEV+CA9JsWWORZCgn8is+npzAkYY6NMR4bW155mzM1wKC+KH2hyfmcaK/A5KwJBS7rc1szk5lb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846714; c=relaxed/simple;
	bh=o3eeGsX+yszXtSqzF2DLz1DisqDubEqdKzbb+20VdL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBGrWh1zneq1mDdfvokVGPGGDQH8fhdtQ01wV7ukfy+iFnARj2D2PUQiw9ANlW5pOUa/WQCixwii5MElFPwh7QHNoHhy5TzvoN0OMDyeU0Yp/r2LKPakwmRJ71CDRpZRh3+dNm7hU67LzOMm9QgSq4l2EYBrqI92GujcvNOj6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myf7IeX/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myf7IeX/"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so3496064a12.2
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 22:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846711; x=1789451511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eU2hqSZpbBss3ZrupUP6xipFsBQw4quqy4F00JT4x5Q=;
        b=myf7IeX/+05Y3Tn1izrcmERgQS8Vfx6CVF6FW3ngqTaIdFSiIdG16WmihxH0YLjCCX
         Gy5ceEaTSeNICeWToDHgXky4GkNV/P+0GHiJCu2v0PokfndhnE5qBcPjE4jcEIVVwkgv
         CAj9wlbIlc/uweyvXM+mZOx2mdYUbxWVbfBiUnZn+AprpUtRpjXLMT3QUUCtxs8OCfKe
         NzBtJmRAvJNrra8/hQ4X7VAz2+FTlXAzjgbFC7oiYBui0VffFPqUpQuOCuTSaBtLBG9q
         IY27exNrhER6cm0kNq6kana4Uqp5MOkgL8AQtzg7Ffj7J0gT5TkbeET83r+hXzwwH/kb
         UeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846711; x=1789451511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eU2hqSZpbBss3ZrupUP6xipFsBQw4quqy4F00JT4x5Q=;
        b=Pw1pYxgp0bSJAmNubByBEmQvLuIvO45Thn4oaWD7V7F9pevGIvQi9VEaFBO5GPtUP0
         Qz5EyQoJYIqPSNX0T01YdSif8dDJf28kzY5jYGLX0BMc039z1usAlijalWpG0IOGhFi7
         sEIwnNJvTv5sUnoDUraB+Y1Ed/Cg+wCdhWKgRErj0/yphKwIDrTWSeMiBLJbCQ1xiBGK
         WdOb0euzvz9h5Hd8dU1JOvGkfOl/op2qwYS+TmunObGvhB+IKRPnoumathjOQylHm8TO
         /RyJ5EEKKlqbOPtrx+R8OZDByc14Wjqw7ZSV5ykKW63twrhfZy/poTibpC0EYbVR1EiI
         xMcw==
X-Gm-Message-State: AFuF++mfS1UoyaV1DoOKGXF3h3AXCN+xM/blxkt3UVFJ9UiOUI7bIc5s
	KcU6wSYdHYbRIn8rRn6CgimgnJ4wHr5D/4RPqdMlg5rQT1PNmm+UDKfJ
X-Gm-Gg: AYBFou2olEL0sc6dypKaaegJeu05MViSYUEKTS2AXI/AF1pSBp+FlpUbxJ3o3o2IFXm
	jf/w4u5kwlf0RD8WuW6T9p849X8orivAaPsDb30cn6f2zbhxHhGrS6RCbGdgJXCI3K6Y4W922rO
	nBWLUKhkx/Eurat1rbTcPy8RiqXi8pMGRBGnEoeXwThD8z8A6i9fgUMO6WWFQf+/ZP9EkS6MQ7r
	MO+FzZ7OStjpxS4wECrL2bjAEGxmGL8zQsk2PKWKa9gutWuGHVgpnWt4yuo1G58XJ6UI1/YI+Gp
	CIELkexRM0IaDwUz41MR33pXJ3asumF6xNFtHrP5pe2NiNfTa/giTcp+W0zyUq/zpMdgmrHzw2n
	lpwS0rAWBWKoy4IUB0+6Dz+puMBtwaug6JishIttgQSomAcAgKb69rbcpiiuR8YlnOjYzgsDaUi
	qJujfnljZw3i1DFjfxtvoIlcDssap7obV+fiYO7ywfhTKTNz4nGdm2JWBzMr9zJTPWBrMcqoNkF
	YodN5CYubb2eA==
X-Received: by 2002:a05:6a21:648f:b0:3d1:5c01:e6cc with SMTP id adf61e73a8af0-3da39f7bf83mr40842064637.10.1788846711161;
        Mon, 07 Sep 2026 22:51:51 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm37719041eec.7.2026.09.07.22.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:51:50 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] powerpc: fix repeated words in comments
Date: Tue,  8 Sep 2026 11:21:33 +0530
Message-ID: <20260908055133.16469-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908055133.16469-1-hemanth.selam@gmail.com>
References: <20260908055133.16469-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/powerpc/kernel/paca.c             | 2 +-
 arch/powerpc/sysdev/xics/xics-common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 0e263b97e016..2e0c5bac250d 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -101,7 +101,7 @@ static void *__init alloc_shared_lppaca(unsigned long size, unsigned long limit,
 /*
  * See asm/lppaca.h for more detail.
  *
- * lppaca structures must must be 1kB in size, L1 cache line aligned,
+ * lppaca structures must be 1kB in size, L1 cache line aligned,
  * and not cross 4kB boundary. A 1kB size and 1kB alignment will satisfy
  * these requirements.
  */
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index c3fa539a9898..c2486b43c5cc 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -384,7 +384,7 @@ int xics_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	 * the corresponding descriptor bits mind you but those will in turn
 	 * affect the resend function when re-enabling an edge interrupt.
 	 *
-	 * Set set the default to edge as explained in map().
+	 * Set the default to edge as explained in map().
 	 */
 	if (flow_type == IRQ_TYPE_DEFAULT || flow_type == IRQ_TYPE_NONE)
 		flow_type = IRQ_TYPE_EDGE_RISING;
-- 
2.48.1

