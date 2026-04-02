Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B6E3D413D
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151067; cv=none; b=jUzgfwo77coupSR1RIv1DetqRv4v1Xg7G8biAtyL9WTAhQsAClpLiZSPDKk9otvBW5TBrY9Dkokh5NjLbNj3H7vfil3RNHxfVf5s7+jHQ1grNIDnGFbZ/w5JU5zlPSiBzJYbkSH+vwpfellqrv62pUJA8tWRqgvdhoWQfwMenZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151067; c=relaxed/simple;
	bh=bz1PD9XLinTkJOb+HRe4/8KWqjjiYrFx/Gxzb9xXPdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jjstZlu8uJURb/tMlIt5CUFFh7H8e4/pE8yDfvtLJddeLFOF12E+AduMm25sBzuMcthLK7yxXXaz9deUgIjPV7PKqk7n82+CAgK9PE9VY2/JsQDRuRBf5Q6N9uXXzJ42Nexdgheau9ZrVjc8Zsrd71EClfVEuDeC5aNnF8AcMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFOrpoth; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFOrpoth"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-681a607e76fso779213eaf.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151064; x=1775755864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzrGyK2uc3zUqIxfmzmHZpI3JXkJONbs+6fwqNeAC60=;
        b=bFOrpothlL6eHu6IsMo3kVQ9CWm2f8YywsQnHdSqpz3ZpiuzxJ5vRHa64MOdftnWYW
         hhjtPI19wRVreY8g50nrAsVi4PhdVy/MC6xPAgs2Xvg4s3A2t0JwngIJ3PAOCZ2PgZgQ
         szodvCTpohf629H5MgOIwKkrzYwl83f6tEQRBpve/DMUUVt35uo3dKJGYCg+52rq11hN
         53liCYmoFFQTGLxLg+X1Ad0tj6/6+VmI9ZlcUsje7y2KDrwHfiXmm/T022aR29fMS431
         c0mQ17VSrzyyg7+mtrkMISMAgFCCEJsiOLtTnyWMwnIVwHziNtsijL48DqNohnvv4rvm
         +f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151064; x=1775755864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzrGyK2uc3zUqIxfmzmHZpI3JXkJONbs+6fwqNeAC60=;
        b=ZRzopDlq4Cx9RQ8tHhltuHCvIMf6ZbX4cG7LiWxo1zL4gXfMp224hQAQKNdH2iB3Iw
         G7O7Ve2braB9K6NJXbPAWDIonV/IOu2pjsqBt5Tu8cUyALRiMll5ru+zK/PRuqc+fmcX
         ODFM4iKDTWFeCCqlSBCKTpnhuJGaeV3yMF0blbug45Xlq/FTyAL+NrcRD/22Pkthf37O
         k4Ya30ADOYTvJU/VY8XtykrtbVv1MYrZUD/yqXwwNDuUmmkxDmOdg7Riba80vILrOubO
         s3jS1lbhQtPz54Da9Y64B0IYfjJd/hoHCiTh4lY3NQBtr8QEAIMYEwsGh7CZQjAS9kiL
         AGJA==
X-Forwarded-Encrypted: i=1; AJvYcCU4DEW4MJDxcwgT/Ua0/vveLOAkzkISTx6jxRpjnCi4EcxGlX48SkzR40HHiAk/v8gvXGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEiGrbqmSgFcas+E55IyWSZhc5rSJ64Lb4JPZYNCzTuxSjFiRJ
	Y66eEH1eGvLGfCQIsB1ZJ8xJJhzj7iWyciRrtmboUnx6luPCObK2ncMPwqLxm9gL38+RlBVJLTN
	iDxRRQ+21NQ==
X-Received: from jabkl12.prod.google.com ([2002:a05:6638:a98c:b0:5d6:7669:6fe4])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:a08:b0:67e:16b4:aa1a
 with SMTP id 006d021491bc7-67fabd0842cmr4453106eaf.54.1775151063588; Thu, 02
 Apr 2026 10:31:03 -0700 (PDT)
Date: Thu,  2 Apr 2026 17:30:52 +0000
In-Reply-To: <20260402173059.1018805-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402173059.1018805-2-rananta@google.com>
Subject: [PATCH v7 1/8] vfio: selftests: Add -Wall and -Werror to the Makefile
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the compiler flags, -Wall and -Werror, to catch all the build
warnings and flag them as a build error, respectively. This is to
ensure that no obvious programmer errors are introduced. We can
add -Wno-* flags in the future to ignore specific warnings as necesasry.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 8e90e409e91d8..6a9ac6dd32cb6 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -23,6 +23,7 @@ include lib/libvfio.mk
 
 CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
+CFLAGS += -Wall -Werror
 CFLAGS += $(EXTRA_CFLAGS)
 
 LDFLAGS += -pthread
-- 
2.53.0.1213.gd9a14994de-goog

