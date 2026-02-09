Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC63815C5
	for <kvm@vger.kernel.org>; Mon,  9 Feb 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655474; cv=none; b=Ih7hkDGpWUl9UIe+dAiZRS899rTfkzI9VRd0ibzwty6+VACiyxOUL0eghsXRt6A/EVf7B6SF5kC9Jo7F5utNd1D0E2HqfYp5XEVWsFVLOT6gHG5XyW5M5+MivRp6cwkHiZX4MkKyuKZWknslNLbrysAE0bunHTfpdjc3F2faQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655474; c=relaxed/simple;
	bh=qOdbHihH6vZgVLil9q6VkyZFhGbxkc0fk/LtZB5SUsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hzMrFFekbQYxCzS9TzCZCTnfl909LqFenqOT9OlHZGidk2cKFLnnTsiXZGDAcGX3DnMmAD9pZCsmpfqWwTkKMX+XH1jOdGtYP7dJOOMBjpiDpqrp0dA0eYrzSGICXqGvAdQ7r18Jnh7FxL9/YKuyUX0oj8PqEpxqcqUBrKs0f1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXJAp/H6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXJAp/H6"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c56848e6f53so3022934a12.0
        for <kvm@vger.kernel.org>; Mon, 09 Feb 2026 08:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770655474; x=1771260274; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A0QzCUGiqz0toe+d8x40P9WNXlmFYlDBcgqeVRnBVLE=;
        b=vXJAp/H62r3gNXDMLdD5dHTsalvW3bL1+svTIbb13mef6rCQTtkMWTonlJM4QUX7/d
         7Ck2qyLNANXsQ9lgV95/uehQ/8zRCq5rdJsSTiPQYW0zoECpUCmN5Ow1P+ZR5O/xopqP
         C5RSrlyX7ZVvY8Aa75INCpmV72KQp2Gm28AkcRK1EDzY/RkLzLvIhGwFSUdoOpl+YGrf
         Ps7FGJCreQJd8yhP60yA090/qa5Yd6Ku+vI1cwMR0TfqyvoXP1LEGFfCtPv3GPSV7/3F
         WBgHC5UvrG6I65FNG5yo03mAtFmJfZ9/G7lgRopd36GxiUezjv7cZ91GVhYdTFm6TkD2
         clpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655474; x=1771260274;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0QzCUGiqz0toe+d8x40P9WNXlmFYlDBcgqeVRnBVLE=;
        b=gNT43mTkhbvKkxowE6VgeM8xKs3GPCzsEQUywyI5ojZwZVjqj3Y66tHICgCpvY91Jc
         nur+AhqlOR1O9l1K7lMgTioZdIcqQszlmmKF497aPdxgZod2mB9CfybpHFyKHh9n08WE
         lZ4bszVg2ZYwTQDWX632zE9MUh8C9TR5GQ2DgFtnQtEKuwZU6P2anBAJOgF1jk5kfDrm
         Qi5x/j6bncd25RmLBf0j/AOHp8/Xu6OP/kUV1EZbbE3lZpepGrQYSff9LnevcSll4WXI
         XrJV15fgzC7tk1a0nDXrJQTvSJ8CLjQLGhmVlMsXYD4xoSRECW4Ho1G1llDlKROfboIb
         cTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8R+X7B6fIuxeYyBqt710lbUMp9g1mxUsa4I0VbJaRVScfD/8Rvnz39sAOcKr/NA6ZveU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC4kl5yMJrtx/WIUSSX3rNk+v6LmuhK80TXa09sMpxlDW7K9Kn
	K0BcrqlCJZnireNSSeXytgsFx/b+5psR8OHRxMI+z2xCXPl8xw04bAPkRE9aSeMoy8ekqcaW2Gv
	it4CLyQ==
X-Received: from pgbdo14.prod.google.com ([2002:a05:6a02:e8e:b0:c65:e8e7:d49d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c78f:b0:38e:87b6:9b53
 with SMTP id adf61e73a8af0-393aef5f109mr10345963637.30.1770655473834; Mon, 09
 Feb 2026 08:44:33 -0800 (PST)
Date: Mon, 9 Feb 2026 08:44:32 -0800
In-Reply-To: <20260207041011.913471-6-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207041011.913471-1-seanjc@google.com> <20260207041011.913471-6-seanjc@google.com>
Message-ID: <aYoO8MJKHV-REcMS@google.com>
Subject: Re: [GIT PULL] KVM: x86: Mediated PMU for 6.20
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 06, 2026, Sean Christopherson wrote:
> Mediated PMU support.  Note, this is based on perf-core-kvm-mediated-pmu from
> the tip tree.  If the KVM pull request is merged before the perf request, this
> will pull in another ~25 commits.

Perf pull request: https://lore.kernel.org/all/aYmF-cST9h4MhX3I@gmail.com
