Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34538E5DC
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741892; cv=none; b=XRxM9F9QpZltjl8T6g1TlpK7UhHjqYRhLwHxkH9OpF7oUEOntqZ/FKZIbyV7VDd3xK2UZS2MKlpp8thfjekcJdcBT4e6Kji5gNdwicdeCahxflAoAG8SdCAFcbrHDb8Vx+mxI+B3y1onXEuW97zblM9R8XtUZA7XCjg7AUiubao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741892; c=relaxed/simple;
	bh=D772wZyIi2zII22vNrJ0r3ZaxDHDckPZJ+sviKougUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRu7VXD7PcA79wIEppqTFg9/L40ept6NWduSWRIuuEfTwIiRNdZZZLPAnJjgCummvm2hZ5G9+tqkj5nGfPvQkLQELF5i8a5lxMMwS4zhj5gJDpxZCL2i34N5jBaD9rtHhfPJAo4d5y4RL4Uip/KDN8Xe5mennrqVjINEhmBfaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzUOfgk5; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzUOfgk5"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d9004a1ac0so5218125ad.3
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789741891; x=1790346691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NOxqyYZTlsnROwyuOcMXRdlQNMNgyRf9TUPDZfpO7c=;
        b=gzUOfgk5luw0h4rtyCkcfx7E1U5evLoumshV3c72Y+HvQkored1lsLICRYbeycutqG
         21vvgEAREjmiA/iLz5qZxukPz5QYmwsTGFb3JAHPY9m0V75hR4e2lnlruMGZlbB1yD/x
         z6tP6HxmjHSagP4XHgT8DsQ2t0zgulRaUM/NfNP/Rn8L6tjWuRXg5H0cI7q8Swp/YTBZ
         09ULP5iqhS2dKjQE5KDsfXdYx40V8hMZ1mBDMLqyoOuiw+5LQI991p1XPFTz/pVoY3j3
         NqYej/kxBYm4A1gJoErvkcKrHBjMNOdCG+41vJN8cWi6ykwlx/fYx2/ebpkW+UTctpo+
         +exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789741891; x=1790346691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NOxqyYZTlsnROwyuOcMXRdlQNMNgyRf9TUPDZfpO7c=;
        b=KbDV8RH3fe/HudHp3MHqvXReCaLcpJY5yPqN4FfH9Cqw5DUnHsZBwAjh6NO7aX8Ap6
         b2V7lGQZ7ASfssY/F+VfCD4btR4c2ES7tdy4PuPTbftqIuMbR5myOwDl1cYGaO5PEwTP
         qSjj7QgfWd3DGGZLvyybB3n/3o21N/2DfjIN/C5wJhr+KKN00KyK0fM6sP9V1cyKmFtc
         GzTkqlFP7FKJsatcm0w0fDdePasxeVzWxFER5QPxw1Kenk640s0PkID2P4EcPVdVrguP
         u/LCoURHysPEpnrePRDxmxgh9OhvVvVofEO3XKuviGzemKl9Q2JJrNTKlz6EH5Xxobni
         Yb/A==
X-Forwarded-Encrypted: i=1; AKwUvBwLWgixX42/kjNvEZLe6iObR304tLu20LIAGb/aiWJZmZNYEdzHENRvrzyNFWET6dmWeC0=@vger.kernel.org
X-Gm-Message-State: AFuF++mwgRHOrFsYEQa2pCkTMnqCRzNAbTq8Waa/g0skISu+fZR+AiCz
	0CtooSi7Xn8rWHv9gE3kfrlC9LAWIyLV3xFWQ+0nCKK5LOiyZ++DC6+8mwFHf5Y4
X-Gm-Gg: AYBFou3HWWgkl015AehSiUxUx3/N0xpmifPYerAJdeeuhNpMCAFYQDJXKMo5ZH+Bin3
	dEgeBjwxdZSzllRXASMvmDw4Tw5sWgMWzs4WwwzhNI5HoBn6gj0dxzTk35l93DkOIFLuXyx2E7q
	KlPnG2PkGL97kxt3sJxbgzp8I5TTyyhn6V2foO36cmyeFe1HHRcQm+I2etaBGnkHnaHa3bBVzJA
	6y4ouHdaLBe0GvNoVxkKupPQ97n2q6Ei77B7QkfK8wAymnzn8LIksnG6IqJPBm1JceMRW7CTK3H
	ghB6a8dgufFXUBzvf3vTvbjX0XXBzm+0xPc5UzIHNtGPWqDJTzHkSopw6rnOwBZF4ovmQE0J0CU
	iX+K95UVVHzC6T+dni6+C9SLHlZr6z2bjpEElNkkFccRgH21VczsmJe1r44uVIvKqylOW+ON9LQ
	SVHUUo63p5a8NZLkY937Mx3Bb1Ok6eT6vxuRFAZY8FPYoqPqzOMHf2KAE1AAJuhgP2qVZTR2ed7
	eLI3rekSGtD8h4=
X-Received: by 2002:a17:902:cec5:b0:2d8:d4ce:9f32 with SMTP id d9443c01a7336-2ddb1b79d60mr56947675ad.16.1789741890428;
        Fri, 18 Sep 2026 07:31:30 -0700 (PDT)
Received: from nixos ([171.239.145.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb7527947sm9188825ad.21.2026.09.18.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:31:29 -0700 (PDT)
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
Date: Fri, 18 Sep 2026 21:31:24 +0700
Message-ID: <20260918143124.9913-1-kaylovefoss@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
References: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kvmppc_gsm_refresh_info() function incorrectly checks for the
presence of the fill_info callback instead of refresh_info.

This can lead to:
- NULL pointer dereference if refresh_info is NULL but fill_info is present
- EINVAL return if refresh_info is present but fill_info is NULL

Fix this by checking the correct callback.

Fixes: 6ccbbc33f06ad ("KVM: PPC: Add helper library for Guest State Buffers")
Signed-off-by: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
---
v3:
- Resend to fix whitespace handling issue on v2. No code changes.

 arch/powerpc/kvm/guest-state-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/guest-state-buffer.c b/arch/powerpc/kvm/guest-state-buffer.c
index 42843eca6727..aeb586ba4523 100644
--- a/arch/powerpc/kvm/guest-state-buffer.c
+++ b/arch/powerpc/kvm/guest-state-buffer.c
@@ -598,7 +598,7 @@ EXPORT_SYMBOL_GPL(kvmppc_gsm_fill_info);
 int kvmppc_gsm_refresh_info(struct kvmppc_gs_msg *gsm,
 			    struct kvmppc_gs_buff *gsb)
 {
-	if (!gsm->ops->fill_info)
+	if (!gsm->ops->refresh_info)
 		return -EINVAL;
 
 	return gsm->ops->refresh_info(gsm, gsb);
-- 
2.54.0

