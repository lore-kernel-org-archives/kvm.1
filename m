Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99710331EDD
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791580432; cv=none; b=P6RCeYWcLGBg9J2/YpV+FRPGKg7UNRsyezSaJIca62zwxdm3l29W9Ib8RrgnKnIotYX4KEYAfgColli5o88/3urCRygru3beO3pXNih8K2CwDOw6hVa/uYLe1l1t5LAz71QiQxTh9ebk+zyH5jmtHzd71w7plxzXTgwlpu+o5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791580432; c=relaxed/simple;
	bh=f2/MICLCErTodlF6SfyHDMCXCSRgLawKzwcMBFedg/0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nc7gSziz3V0RULms+0se5QL/swXK5myzZvjeRPqAjdTtMbNpB+HkPMxMKPsaZOvHn3J5hYargCRADdA/t3NuwAAFBYQcXSFFiY2W4EcMTGm1YzG/WYhk4zSX/VpDo2Dk/qf/nvx4X/sObaKm9yNatiNZkttUjMSIaMTdQZQ5WI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubI5L0GP; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubI5L0GP"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e818ca61bfso1024335ad.2
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791580431; x=1792185231; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f2/MICLCErTodlF6SfyHDMCXCSRgLawKzwcMBFedg/0=;
        b=ubI5L0GPFSQwrzWccGT9khVWqh5E++pF0JOt4x4YirBubEqEieyrA++qcWW2hnartk
         doBCCNuhzkDbL6Ij3DvAD9qGPZKLHaWSREY0E9/OYcWTL5Uca+YUpg4U6X8sV0+mVWwc
         B184VeLSE/nr8iMVnV8SCSsXR2nSN4F8DYnzpnLkscqf6yj0BBJsH+8H/Tl04O/tIIvm
         FZ+4RQ5KDCnwdCPXayLnB1HlX19XXxTtIUqv6vf3UWMb6zdSNcvMQcmJCKfwIc5XtKGC
         41g3GfVWKhHAJkvGQPSqGiMefvzdpxWM7rpZGGOSUFFD1aaCE4u7XOU3+ISLtAvg90en
         uB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791580431; x=1792185231;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f2/MICLCErTodlF6SfyHDMCXCSRgLawKzwcMBFedg/0=;
        b=CEAV0RdM6UcwkcMyxZrIOTuplUwPcelr5EjI/ZK68xyM3SvLqfnNolUN8VC1Nc44EI
         CdvDwc8vtUTCpdyeNcsvr5m1+kcCdoDgBkZqKDnnC7J8rnAHsJ93xwgu3rYZz146+aXF
         yvKoUinmcsCvCDlcpKNq3FWTUPuiETmF3glCZztNL13807/sZmFH+ZEx49SJHOrLLWg9
         ztHfukvu433LX/fQQsPxckFToheeasjJI2kBFIe/ZTdDObb252lceLMrboRVRCeC6zcZ
         Wb2no+ylClm1BOrnjRibNEZrJ77u8QGe/DuiMvk4poOf8GQVD+ccCE7i+0B3INcExewb
         u4nw==
X-Gm-Message-State: AFq9FYKB1GSY2FrHXuvzQ43o/XozVt5/Yzo9L2wqzDpAm0GBZEfOeV8e
	O0ggF9wsVs+e1ygS0fHdp6w//u1s2SJT0UsuyXRHWyOGbwWOgXDzRAHwbQyh9Se7BibLJLw3rbH
	lZTaXSA==
X-Received: from plri10.prod.google.com ([2002:a17:903:32ca:b0:2e5:9357:4fc1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e849:b0:2e8:4ef1:6fd8
 with SMTP id d9443c01a7336-2e84ef177e6mr20615815ad.60.1791580430759; Fri, 09
 Oct 2026 14:13:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Oct 2026 14:13:49 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261009211349.112524-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2026.10.14 and 2026.10.21 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PUCK is canceled for the next two weeks as I'll be offline/traveling.
