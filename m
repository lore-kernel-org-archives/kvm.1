Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753430D3E0
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 02:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782180434; cv=none; b=asFjB3esgKWysLkRO72gYuMEpFKICZRqqYKy5BDz+dWBlXfCSnVJ8uZId6JB2OuWmkbi90voSKYQ3Z0Qm+R3Y3AIhp0qz+/D1fh74LEYmXl4UCMvLKd3khPj0U8STsrtekgTtTJ0m3BX6fYcLh1LpO0mAV3cGzCf0F5FbGsn29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782180434; c=relaxed/simple;
	bh=4K2rc/keiADBTmcCzAYpI+UXrdsZoBJ6VPBmODXWpBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kt84me1TYmCR4usdGSgMOlYsrvmu61brV3UgtVGNBqBq5u/cWMRlOPKYcHySO4b+FjCgj/TPJJXMgKIpuZZVocvrs5GloH2HDNIXQrDiTYmmFldgd5kJbR7LvH4tnro1KdHfDXoQPA3s7K/H0qdgoglgXgQBfRrmatkuAP4Dc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NfcLUwf1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NfcLUwf1"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d8719bae6so4034683a91.3
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 19:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782180433; x=1782785233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=16OIrO/rsCCNlasgtWoObyCXrmjWyog2BYpUhpGypjE=;
        b=NfcLUwf1bqaievrKQIEbLPkxj33AsN9M1CZ+pQDvZ6f7JI2HqnzktzdU6yvmd7SVCu
         67jFrxgwzrawQybdu5AN0crCn3YMpkv72jlrV+qjJreyIE0qSIUX5Wr4GDqKUrArJN9C
         gaiULf3unPMWfiuDlDh/rVhMXnzRyIWUnCrmF9bvQ5Mub3pn3kRlJ137+TUSux0ZOEQT
         wxrlfWrwIXBqYdOwRYl2bFCgIX/YFIJDJ6m3Ew5WBKYRGyRJT7xVUirVrTiAdsRMaF0Y
         FPXht5OUyIijXLkeEGi+ZJktxzSS7y7/kNqOlyqdALdr509lz4A5cAKB5FLhYqhY33Tq
         0qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782180433; x=1782785233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16OIrO/rsCCNlasgtWoObyCXrmjWyog2BYpUhpGypjE=;
        b=DZ/YOrMbXh1ouV9sfh81qgjF+zozLND0jKRCCJAOiTeoi/lZVQm8W8vDnwgvfDKfhN
         C78qeL6wgy3Eg/e0+xAklHTaihajLIFjibAjxJm5xnJVIIUDAQ0OgIpU1yWuRkM0YmSo
         bxDQ26h3kdygwi8gbKmvQpZNTbYPI30E6ZqFPmM2qdoEwRY3ZJMAVKXL2jN4eoQ5akCm
         dfIsKb6ndZ36gFYh01NlQGI7qUahVgKXB+cu1E49PsSGa3cn9ev6VLowOXNcBenNYY5K
         EaH7rQYrCVyMAsGtTm5X+0uM51uiKhRwkMrFQKQixW2FOh5brFy7RvXnZK8HSmVufYSb
         7VEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rob+vAAvTmoeY7L1E6X43h/6i6OFYf3etYuYgUsu2PN/F0AcJm0/pQz4XzL4LeJ6DUrzXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89QJdyM8uqVXZTir13gdUofZEuTs809zxK5ut9Frqj0XNj7CM
	JWA8Oq9l9CaZQ5ni/SrQqntJu4QDqkrnE//vIv2Z7lheJ0Vx2SSuBLEiO3SQnJCZ+p0+IEILhaG
	6YS3ORw==
X-Received: from pjbhi12.prod.google.com ([2002:a17:90b:30cc:b0:37c:b313:3c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c4f:b0:36b:9798:4f67
 with SMTP id 98e67ed59e1d1-37dd16de36fmr630782a91.8.1782180432324; Mon, 22
 Jun 2026 19:07:12 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:07:11 -0700
In-Reply-To: <20260621133722.0003.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619203107.2752678-1-main.kalliope@gmail.com> <20260621133722.0003.sashal@kernel.org>
Message-ID: <ajnqTyhKNqOjKnzF@google.com>
Subject: Re: [PATCH v2 6.1.y 0/3] KVM: nVMX: backport virtual-APIC host
 NULL-deref fix
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, gregkh@linuxfoundation.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 0wn@theori.io, 
	mlevitsk@redhat.com, jmattson@google.com, 
	Nicholas Dudar <main.kalliope@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Sun, Jun 21, 2026, Sasha Levin wrote:
> > This series backports the fix for a guest-triggerable host NULL pointer
> > dereference in nested-VMX virtual-APIC handling. The bug is present in
> > 6.1.y and fixed in 6.6.y and later.
> 
> Queued the 3-patch series for 6.1, thanks.

Backports LGTM, thanks Nicholas!
