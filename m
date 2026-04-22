Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F94A23
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853054; cv=none; b=iUhercWnMcrmBwOmHe9HaJFA9Bs7r46kMIEzam+SbslA5EfEbqYCEGqEIDxRJkWmDLcV041wx/jE0mwFQNqkx6p3MuH/URqUzNVdvhmJOoovHIhs/xaQ3KiiD9vFmGMWzrXiv8Df+f8B46JLK0ucBact47seWl5VlQn7hmGzg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853054; c=relaxed/simple;
	bh=piPF6Nc23auS+g4lYiJQkYf5/GW0MfL9OBLDKeqR99w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyjX41BVi6Mk+EFIW4nB2MzQLe9tID2qX8tVPvXeeuc/eIj9tYapg5PBc8TvcQtnE+S5mYJnTQTJZZ6oqoCkWMJSUVMyaT4knomLxQNhjETxHqNwutwDu2dY6wVGWPlIbgMQ6qRMeN0kXIt868ovOC2Jp3r5fpI9+VFuiTBP9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VOaaxi+D; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOaaxi+D"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso31784925e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853050; x=1777457850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9WNiVc32x9uwc9Kvl3F3IabOVkUVJfyhaJuWqhRbgs=;
        b=VOaaxi+Dhhbd8++hDEatOurcc0OSjviizT8f1S73b7AP0Kw4Pd9hbSMPESJgMB4hOd
         l9G5LUagx+n53OsAknkPLz+2W6VcDXMFNLQeRvHKkYd9rsexjmXG4sOZA/KiE1TLkKuP
         12Zoquns7qBxaGkrrUvmCaCdlYVFavPtFl9kp5IAs7EnNU7onmIFjbyW3dRgjALpRs6N
         NTQGDV4rSUtuW/ZoU/IF47/LfmHCA9Y9B3AHxnAYB2teSvUWYMfzrlYex2PX1exMhIxS
         axB3+oiNqSEhdY/cnfGBZvLKDahNL+8tvXf0DqaS7F2Gp9wtqHtXfZ3QbBBtiC/JYMRE
         RVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853050; x=1777457850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V9WNiVc32x9uwc9Kvl3F3IabOVkUVJfyhaJuWqhRbgs=;
        b=XHGJFSEqB3QVU2vbC7C88n7HOJUuP/fndr2/5oHHRHFe5vnWFUt/DSOp2bwhHRPhVq
         xNJnL3qNI+KcjzpVMjcPCCcMoDO0gEbUZkPy0zq0bD7E8UKGXaBfEoTLK6VdATjJ5vUL
         4PRWr/Hb7tdoZjp7rU4DzmXiJydf98k2XE2ZISCRhralzsfFSYQgV0joP1d3QJhLV05X
         TIqGe5UcnvwCc9W5fzhQq6fa+tbknQiVXN//8NvH3M6eu/1IR2Ui1hkcVuzUBzdJmuft
         2UqDlNe+r6ZMHOLVCpl4gliIb3knHdX0DkmhGMPIaQvW+5EZdngtgC0rPAdNFG5KipyK
         b8Wg==
X-Forwarded-Encrypted: i=1; AFNElJ9eyrSNEIPmfvbrHtOA6GdgjrqkYHuWVzphpY8jyFLlU03TtcQTmA5igaeldaTR1LPjPoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNn9PvFDVgUd+pjaYpp5BVoIM/DvRADXS1HhlxtUNv3O6liQ6
	M3EeabKD2vaWzzss9m1NapuVUsArFPF8SpFE6TcKolZgpDm/tAbBXCtccVncF/hEBZI=
X-Gm-Gg: AeBDiev9HCdMj7+lnUresSYWpqvZZ61JHN4d9ydDAxyQ7Qpc85RTTtKyE6sbTLpAYqz
	soiCFf648SsqVBrVJ/IlHf6PuKHS4Co3wvyw+fi45bH/4dHRVrA8ok9ONHTVwLpdOIufTzC4kBU
	8zdFQ1y88u60R/4hnD53TmLNlABN7zZKc0e7qNGTA1Wb0yiQzm/JeW4ZmkOg6yN35Q4g0+IblM3
	+KokCJWsCR+hOS6vxAgpgQnGsf/MCIR2SEIcNsmcM01bdUCrYqJWctS/5jc2SiHebj4Cy7bfzpg
	3OehhYa+O7Wid2x7Y0Vq5VNJqInULDNIPzgsEEYVQSB9RR7ft6QCzx3ByheY9Z7f5A4hZ+OIBjJ
	cS8q4Vau/hw2YvZSsn5JE2QfGdBlHrK8kFP2DoTgC8gtWKXc+wZzR9hiBO41BuZCpcakDGtfCyf
	0CUIklY8OZPssrfQ6RVOYvMbEty1hDnGM2zw==
X-Received: by 2002:a05:600c:5254:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-488fb6e62a8mr333377305e9.0.1776853049667;
        Wed, 22 Apr 2026 03:17:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c08faffsm420040875e9.1.2026.04.22.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 72EA26153F;
	Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 25/31] target/arm: redefine event stream fields
Date: Wed, 22 Apr 2026 11:10:36 +0100
Message-ID: <20260422101043.1234229-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The event stream control bits are the same for both CNTHCTL and
CNTKCTL so rather than duplicating the definitions rename them to be
useful in both cases.

We will need these in a later commit when we start implementing event
streams.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h | 11 +++++++----
 target/arm/helper.c    |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 85980f0e69a..dc593f1fec8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -263,14 +263,17 @@ FIELD(VSTCR, SA, 30, 1)
  * have different bit definitions, and EL1PCTEN might be
  * bit 0 or bit 10. We use _E2H1 and _E2H0 suffixes to
  * disambiguate if necessary.
+ *
+ * The event stream bits (EVN*) are in the same position for
+ * CNTKCTL_EL1/CTNKCTL.
  */
 FIELD(CNTHCTL, EL0PCTEN_E2H1, 0, 1)
 FIELD(CNTHCTL, EL0VCTEN_E2H1, 1, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H0, 0, 1)
 FIELD(CNTHCTL, EL1PCEN_E2H0, 1, 1)
-FIELD(CNTHCTL, EVNTEN, 2, 1)
-FIELD(CNTHCTL, EVNTDIR, 3, 1)
-FIELD(CNTHCTL, EVNTI, 4, 4)
+FIELD(CNTxCTL, EVNTEN, 2, 1)
+FIELD(CNTxCTL, EVNTDIR, 3, 1)
+FIELD(CNTxCTL, EVNTI, 4, 4)
 FIELD(CNTHCTL, EL0VTEN, 8, 1)
 FIELD(CNTHCTL, EL0PTEN, 9, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H1, 10, 1)
@@ -280,7 +283,7 @@ FIELD(CNTHCTL, EL1TVT, 13, 1)
 FIELD(CNTHCTL, EL1TVCT, 14, 1)
 FIELD(CNTHCTL, EL1NVPCT, 15, 1)
 FIELD(CNTHCTL, EL1NVVCT, 16, 1)
-FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTxCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 40dd070d2c1..81a07ca42d0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1746,9 +1746,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint32_t valid_mask =
         R_CNTHCTL_EL0PCTEN_E2H1_MASK |
         R_CNTHCTL_EL0VCTEN_E2H1_MASK |
-        R_CNTHCTL_EVNTEN_MASK |
-        R_CNTHCTL_EVNTDIR_MASK |
-        R_CNTHCTL_EVNTI_MASK |
+        R_CNTxCTL_EVNTEN_MASK |
+        R_CNTxCTL_EVNTDIR_MASK |
+        R_CNTxCTL_EVNTI_MASK |
         R_CNTHCTL_EL0VTEN_MASK |
         R_CNTHCTL_EL0PTEN_MASK |
         R_CNTHCTL_EL1PCTEN_E2H1_MASK |
@@ -1763,7 +1763,7 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
             R_CNTHCTL_EL1TVCT_MASK |
             R_CNTHCTL_EL1NVPCT_MASK |
             R_CNTHCTL_EL1NVVCT_MASK |
-            R_CNTHCTL_EVNTIS_MASK;
+            R_CNTxCTL_EVNTIS_MASK;
     }
     if (cpu_isar_feature(aa64_ecv, cpu)) {
         valid_mask |= R_CNTHCTL_ECV_MASK;
-- 
2.47.3

