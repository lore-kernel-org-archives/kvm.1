Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315774AB3CC
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380757; cv=pass; b=S8LBhX8b0qj8yLIOukiakX0OuIZloKC107Bew5aSO6HQ5GJG/DpNjNsALPDPVVMnJZkZCMOgwUnrL4nuR32rzm4eId1KCP1XBmjTf4UngpbY1fIhupQg9FJdouE63L7eXuzDRhyZRATXV2rlreGsnc/Ul9FCiduok+cOtYsib58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380757; c=relaxed/simple;
	bh=7R3ym81WdAEtexE6jWnwa4vea2N/jeqsSvQGrEvEZOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arx9ewUooCRNBFhkmxDyLQvfwgnFkC6Uk4TrzCpSolL1n5oXr+YEByN53V/0KGSd0s4pk5Up2M2yBi/dJATqgVNb6wx+nhcKRuoxVpPHlOLJM5na4Hd+Cpb87C04RFiZvSmwm6Dc92YBGkwldDgp+dCxIEWsSvqd1zOZCROfb24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XYxkz+W0; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYxkz+W0"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bcc04c71f5so8735e87.0
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 06:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791380745; cv=none;
        d=google.com; s=arc-20260327;
        b=QdI+WzoJkxuXRV2VDkXfsLEhcinX8dFo54YWf4VyQti+lmciSgXmhorxC1dp4sAqlr
         oVjkLB9yyAxfP7qCzTDJ86SyCLkahCv76EZMoaHejpwIdAhUy7XfXGfXk5VtQjbAKtWp
         A7YC2lC0UpDnFjrZsllHieagWM6YYnnOJYlyiWab/SnPhZC7VfGYiESg/EtEpPe4NuIQ
         1TvS2m3SojOKiekPYo6h31/lQE1Iy3odBq71VkJ4DPCZm+2ijfT8mOOIxqbsodNScxgr
         NAQaKv24d8TlwBJAuJHLcJHgYabdDcoiwxB2tzULx9fOggvoqDLtUZXEovchZ9QMTi4A
         GNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7R3ym81WdAEtexE6jWnwa4vea2N/jeqsSvQGrEvEZOo=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=LuV9l6shjWjbNTP1Czs36rVpKSJW3fAX2StToCGeCunZ6eae/l6t9alJa/czIpco2C
         LF7/Ill/YNX8GiWXR5yFE+gfR82QdLyDyK9FDo1WBxLzxPekO7raXP7ieqTSy729D1nF
         FsTGG1pt4YsSNJPWPDQhj41O6XYQUxo/mLBEQI2WHHXpP3Z5Sjb5YRgflALGENkKWRc6
         VpEpQzFxIclYAuEzkcpkSNT+/XCmT2i/1W+KNWffBzhI3w49QXQWjlaNAtSD3PELxX0W
         PL3apHF5ZEh0MwXMzki004LdH8hulxig9y8ws9CAdCb43P/NjguRbQDwQZdLKl3Vz2F4
         Uxkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791380745; x=1791985545; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7R3ym81WdAEtexE6jWnwa4vea2N/jeqsSvQGrEvEZOo=;
        b=XYxkz+W0oIQZd2ng/uaARCv5WCqKJiG2raclhhxX+4CLNeI9Gtjf+T9FdhVOkI6hga
         Jb/RlLZdujYxzAD5BwRUfk/+5i7C0UQ/BZD7eW3SzTBUdmIzrq23MPvtJXM3Cr46V1sB
         gASDKqGa1u3p0BUQ+kBqRLt7gn1Yhfq4ns7HpSWR2xHpccW6ORy81XxifxIlRa5gK1Gv
         FkAJslTnmlcF0TFYzjW/qdqZvKrafMrfYhST7KKfaEXfnF4BQG33olzG4yb9XWKybB6u
         f1q6dxef/9DXopWBfelknkQTmMJE2LEzhnISVVLvzCwXM/d7SFugQl2eCxOzLdld766v
         V6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791380745; x=1791985545;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7R3ym81WdAEtexE6jWnwa4vea2N/jeqsSvQGrEvEZOo=;
        b=u/Cj/2Y3xHEzhSLzPCpvKfG+TRKxWZ7kvy29Xo3MLq6aljmXxOCWgLirUd/D1sLjpt
         clhIsdd7NPZSW9qqzm/oITUYyWOifxfFPcW2IL9u7yYwGi5KvZk5ixKEbPuKkrQMJ0MG
         VQoq88E3HLdPReDC3sY+6f/PLe2r5MALuTGFkKo2S1PbJ1lQ4jsuic93gMpBcgBSGLE1
         qicRwwhDGrSC7tAXgCjrItKxrU4HNBAg72HyEb4WE7PYMfdsRBTsab6W0VZ7hvD4ZUyq
         cvbBeGeUkvR2zRhPWBcXqRMupqgxNhpgtXG09sWQrJTEaNE2eirUPahllLj7c9NyN6YK
         fMtQ==
X-Gm-Message-State: AFq9FYKPNWLIApO0f4+u1uHwcJn84dbPLDhUCza5xsyIIY3eU+fycMSq
	D4TE2vsxC2hOEMIbF+1EmHGRFDD49vCdtfiE7e0jm6Z5eAjEQ5wutMcQ/Y3W7RxrMEtkS1OMXzC
	AzB9DlH9dPnyHDUYb3V58vQ62OpzmOsB93S/hPQgN
X-Gm-Gg: AYBFou2lFdHxW1ufL7g2asTcibA3Cv2Zf+fAIOCCMz90qQP+3Q14xVjQ1ELv5gwhKFW
	Qzn1CEs5PBLeH6470yP7YqESjYGH5O+br3UcOZpQGAyW/gqVsLuhVv1QOPv16a6mLsNFfz6WDMo
	yHwEn32tbmndcU+horJa9pJB/lzTI2OG5m9t/pVfaMWmtJEhJUz7Oj+wMG/bhqZ2vu/YOuI7ya8
	YhtQhxAckOHS9W9PdI6cJtKESql5lTfY2K+2fWr3C32EBEg9yIrba0Dy74X3GFizvd/dvPe0blv
	WtUmTx0kJeGDf/QMjTT+qVtVbdZg/Zkd6U6h80iMiSmcPGuwRTeULS26
X-Received: by 2002:a05:6512:33d3:b0:5bb:ff6f:b4bd with SMTP id
 2adb3069b0e04-5bcca66e395mr320554e87.14.1791380744549; Wed, 07 Oct 2026
 06:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com> <20261007073537.2454351-13-suzuki.poulose@arm.com>
In-Reply-To: <20261007073537.2454351-13-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Oct 2026 15:45:07 +0200
X-Gm-Features: AclHuK9NBZeYXTKdDsAbHTEgR4p43Lr3P06clWDgtHoGILzFBEkx0SOT-Ggr9gA
Message-ID: <CA+EHjTxuAh1zegQGA0-dNAjDBnXUc036WhoGxoUvVmMW1BxdXg@mail.gmail.com>
Subject: Re: [PATCH v23 12/14] KVM: arm64: Abstract out memory abort handling
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Oct 2026 at 09:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Move the memory abort handling under VM specific s2 operation.
>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
