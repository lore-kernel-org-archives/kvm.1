Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD03D5246
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004437; cv=none; b=Hu/NClVVvdS+5eYXBrYUJmJ0Ir/Kt8GTxar5Ud/qlku/6ykYWPzheDLHfBsijEBfYVlyLPCOAL1QMf+mDuCcuHxVgx7Usq0WORHaSoaOX+GZ2g6T8dJXviyxoY0VoTB13OL7JbbQMulGCvSBkw5lRrLYFLT7twbpTLy9TNP7urw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004437; c=relaxed/simple;
	bh=k0hD3nyHCHFB2BQgUJDhbStcyvlUvLbfa+Q4kql3Ps0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xwopl+54GYiyc0Ptm7fuNNhluUCns/T10KpAIwjLREjVIcBGvo8DIYoF94Jy/752BpIlTHxfzDF8W+vMJcy/TUC/22uHBmsnCOVXRrwXqpKIXNHBn5jy1YLopmPNmRFUXa2T0+F0XrJQrEZ6OydOfzg0bhEZVG+R9sW18j4nu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckVzXo4k; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckVzXo4k"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso27673945e9.1
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787004432; x=1787609232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k0hD3nyHCHFB2BQgUJDhbStcyvlUvLbfa+Q4kql3Ps0=;
        b=ckVzXo4kEg+06iD3IHXvzqqK51KCajDw2jMVPkZOAJpChp2q1UTvefSVGkpyQS5V/0
         US4nw7+0t6ClkM9MYC0zxZOKwILBH+zYcJSblEq6hhTE2ZLRiSHCLh0DBISO02SJIHuc
         EI7LXKIaifkn3L9+s5/021iIjJdCdrIMAFCiC7hIbhwU6ZZuUkunCiyZbc7c3Z5JSmhT
         qZXzC3R/CJQ80kCvZ0dDuR0N5pkQZNASt13YXkJRaTZ2HcoZmQhPPxLgCwfV5xbzK6VJ
         8Kf0K6wQ62FynXjJVMjBbaT5Hn6BL/lfF61d37i/KpSmOTgGSQRYfe8q/YPK8SRXeiCa
         KmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787004432; x=1787609232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k0hD3nyHCHFB2BQgUJDhbStcyvlUvLbfa+Q4kql3Ps0=;
        b=EwAydSxsUYJeMhqdWRsLNN+eiJdhf0d646QiwvMnZs2dPK61UpnBfKthquqB80vBkE
         eNrUy4NjeYaihhkzvo6XgGan8xMc6rOGUlo1LTs834xqfzefXedOt8xqRh3SfAobXydU
         aQhhVvgZ2YpTxJtnhAonD0HWtQMPxSQ0YAAXakVBSt86HKuV5C7yovTlzBhNzJ/NY94l
         mR7b/ZdHUKBuKqcovKO33hpASygT++86mLijqZ2405SfbpbS+iaE6PA8/YFMtqkdh1My
         DdRwQXpUkM66Q64udGy1IXwbTjj/6F8CpwFNdMF+cFPibNxuRmh2XYzyVWXqo0zCTXYY
         N2+g==
X-Gm-Message-State: AOJu0YxEzXzk4Ex1puWUYSOWafe3lrXCr5CgsG7T4wOpYvximbell6br
	RbkA18PsqooL5kqeLtgOZdR4dpaE4R1chWRsGnCTw2OoRR+yiNmKfPvYHFjHoU8SlqM=
X-Gm-Gg: AR+sD10WwUZHvQhe/xO2Yf8reBhsHcUorBAzza6iEJUXGj35MY2jp3c+OyDV8ITo7pZ
	Uj0MPTWlU0skHFEYYoE4gM09CowPm7Xg1hiPbKp5/Q8sVVMehYClH7Iu6s+7ll4fdTj07M69OvJ
	CzC/k7G9TEG7b5/1BkqW30D3ibQ//hKbjdI2yi2QAbrT3pHasNSGz3ZszwJ3EkFKIK1GW9daTJJ
	GS3fjphQgmD9tfTa3pEKfcqc7pQDfvpLOvGfTkQO7hmJq/ghruEemQ7cgohzFBxZuMIfCK/hQgV
	ce3Rv0V2C4FgrmnmF+ss4BRHegBxqxVVFcrHDZ4GYcWl+XdNJpy17PvUSSz/zg4HjBEiOC3H7W0
	zBVjzyWkCQ7YGI7oec1Yl8zMGCAxD0l5fdKgDFPHFuCLhPA69Q1xNXuqHByLMtD7MSkIKDKZpsl
	NWaX6ye9ThnTDtxxKi9Ko91eFt5Bgi20nx76wEiFnsfDlPJWRdwfzHA/8IIImZRhb/ggGH66eW/
	F5SLJnAPwbQlw==
X-Received: by 2002:a05:600c:4ec9:b0:499:8ff5:8ec4 with SMTP id 5b1f17b1804b1-4999fae4f07mr47296775e9.3.1787004431647;
        Mon, 17 Aug 2026 15:07:11 -0700 (PDT)
Received: from hisam ([2407:d000:508:2027:2845:c930:d20a:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998ac6afe7sm192259975e9.3.2026.08.17.15.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 15:07:11 -0700 (PDT)
From: Hisam Mehboob <hisamshar@gmail.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] KVM: selftests: Replace ulong with unsigned long
Date: Tue, 18 Aug 2026 03:04:59 +0500
Message-ID: <20260817220457.554823-3-hisamshar@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803170825.925561-4-hisamshar@gmail.com>
References: <20260803170825.925561-4-hisamshar@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping on this patch; it has been on the list since Aug 3 without
any comments.

The musl build failure it fixes is still present in current trees, and
the v1 feedback was addressed in this version. Could it be queued in
kvm-next?

Thanks,
Hisam
