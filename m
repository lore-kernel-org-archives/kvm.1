Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6E43079F
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528129; cv=none; b=ddUpAroN7RxIIEi9Z9KlgNLIg34/SJyp7+AO3SQJtseVQou59mfJNZzFocY0uYdmPJs8ELuSWL/EPOiPoo0Y5X1zCESMq2mETGWKzA7sDZtKGsjTCwEkAHGOirVu2o1/7Z8yM6k6LhGbIB+JLFyYlHqoiuELheLktV/45cHoLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528129; c=relaxed/simple;
	bh=N78qNTXYyAGe8Pvbr1sq5Ea+xcTA5EsxNNpKXw7f0gU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SX0Pvb3rBQjfK3C0GGHaJI+Q0gvIPAIOM8ejgTze+OicUnPKDvNn3LgJz44ABqB+Ztd7ebJWJYfJFCIWJPEnlFrIxpZBo0j8WPRmnDGYibBllOpE5M5kUUC0VYUO0W0RRBatou3uPbVi+d5vy4/vI5csYZOfRAR/s21+vQjjgxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aiN2/Qnh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aiN2/Qnh"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84854c2f888so98304b3a.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783528127; x=1784132927; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AfgZ9ul2SNF/nsD8LNwMVjZuGCGv+SD+QOqFw4fRLLk=;
        b=aiN2/Qnhj7ZDzBTqsW4GhV1DgA0KP1Xt9kdHoOMHL0rYeI3CFyuXsfDfbg1VcWSGWH
         BToe0RqP4i7T/zEsdRKwUeeAX5qVHYubBm/nK8Y8Z0qoVF0UIKDnszZ9G/y6bURkng+7
         FwTQO7RZInDglu8MTGdzIyNlFWGHErkyUCzgcDrmhWQukN//7wkYapZEGHUCNKOdfG9I
         ITGTpnQ3tb2VG0c09if+5OodkPbE716OtxtP4n42f+4x/Lby0mFZKJ0ZcGbA6J67OEgX
         f2AGShWYvAiT/A3jqeh+1TU9ZHXw+GN1wP1tjYYz16N9Dwvngb6UI6Uzmvuq0M25+dnL
         LUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783528127; x=1784132927;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AfgZ9ul2SNF/nsD8LNwMVjZuGCGv+SD+QOqFw4fRLLk=;
        b=RJu+mMGvVA0M9rOgKyh/7vukVIeuxIbUJomqmTub+ftEDtQY2qyFZjY3jaeTm9zifR
         10f1EdrSOiaUaHjx2pWIF3kuVrVU6R4B6aXwE5+byic07dQOvSqaiiWy9sLEtSJy3RQn
         Irjz0eDG+UZyYDTHWoL2ukJ8fxrT+YWPbFJF6sL3iqm+zpQcLRXj9OT2Xi6C3/mneMcx
         oHMl4zf1W7nNWfWbOK55scwCjVHFaLykioWVn81M83UNBshetr4gRrspd6XGiL2xWqbx
         P0I2ZR9HBRnS/+LM/ghesMcj/8V+JtMV21EO+F7bC8NiEa1unDZjLfJ2f7zahNDSJowu
         xnBA==
X-Gm-Message-State: AOJu0Yxrtp7fjfJhGzXbBE6PLahRJZ1qTid7Ugna4WcXiFevxlORRBsZ
	fhm456tz5V1toaLqbh3a23W1f8eYFMurxyYSC+grMtlTX7ePbzlbSRQ9rdCPkfW6x0sKmEItMZD
	+OnD4Ew==
X-Received: from pfwz2.prod.google.com ([2002:a05:6a00:1d82:b0:848:4642:f1d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:399d:b0:842:2a81:4c63
 with SMTP id d2e1a72fcca58-8484302c9famr3305642b3a.25.1783528126270; Wed, 08
 Jul 2026 09:28:46 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:28:45 -0700
In-Reply-To: <tencent_A78DC401911634111A3391650CB00FCD0409@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_A78DC401911634111A3391650CB00FCD0409@qq.com>
Message-ID: <ak56vdAt3CavMI1s@google.com>
Subject: Re: [PATCH] KVM: VMX: Use cached vcpu_vmx pointer in MSR and segment helpers
From: Sean Christopherson <seanjc@google.com>
To: zhanghao <76824143@qq.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, zhanghao wrote:
> >From 3d30672f614d0472bf15ba9dd1efd085cddd5a93 Mon Sep 17 00:00:00 2001
> From: Hao Zhang <zhanghao1@kylinos.cn>
> Date: Mon, 29 Jun 2026 09:52:32 +0800

This is mangled, the initial "From 3d30672f614d0472bf15ba9dd1efd085cddd5a93..."
and "Date: ..." shouldn't exist.  I fixed it up manually, but please check your
setup to make sure what you post can be applied by others.
