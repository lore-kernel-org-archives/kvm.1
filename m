Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1CE51D52A
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059269; cv=pass; b=eTeCyEK5PnLEQC5WlYslNky5IGFL1T1tsSV3m2Pv8zesNB6NTKUNX7YfwdZFOtG4oqVuEkbdJ9CDTWfzpV/UguqOtXstaj0SW2mrqzstkIfI1lex7JNNQ9tD7HBWUBFB3VKCuE/Gavlh93ycVxjKVYXGD6mNbhHXUW9W07ziupY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059269; c=relaxed/simple;
	bh=L04gHjCTBFQDXGRIDlSdQjb0Hj0ou645OgkH0Fdl5tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfHrbWmF2SMQN7xxMVqrAPlAQtgLxgsxVg2Z479MGhs7LICK7QK4MaXwsYxH6hq8RnXxD8/SDnJSpdxsI845CKjG38LYQ8z1WY25XyEiK7L7jjGoRha7P3HJ8437NXnOxskSStPqZqF+ohs+3psmQyhGgE7GKCAR5+i9LjCczTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tygvJHf5; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tygvJHf5"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4b62d118aso41731a12.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789059264; cv=none;
        d=google.com; s=arc-20260327;
        b=HmxoirZN5WVYqbEfJRO3XXMuOq/JAg6227BvC9bdU+FA2XLSxDXkTCRVRO4q2ApJQD
         keM/kTwhsji1p1FCcHkTZiLoAUH9VmjNt0Zk11U/dwBGAtw2H67erGMMjRWoDjwv5f9y
         SXdfTpf0xfyG5QuiB+9K6sEtlaiE/jAguANNnLXIqWdgN6aU6+Iqu4QlwxeS2G8hcqtZ
         43GXaouixNloNMJOvS1IfyGAafVkxwoWYc9uUV3CdnAIaq+ddFyXqS97UuPEAoS7cfCm
         mNLTToG18PWlDO4uDhxGGwBHYF5m1zgk8b2w2YpKIKjVjB9GpCSwe5+J8KVLsZZd/wmZ
         bIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L04gHjCTBFQDXGRIDlSdQjb0Hj0ou645OgkH0Fdl5tE=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=n0iG+4Jq2/nenmPd/E90O6jyJizZlKZtg+DAdgshqiHR9+nlkczNAww040y6k8Z/x/
         cTO37zt4vNYrfV24n+++LMNkTIOUWdtgCJnqCbcb55KdLpmiyZIwV24pTK2oZ2FCKtCd
         w1HWrfiPENmTzj98DZ/+p4h8YLg26uTLDlkgPmm1ZK1Q5ey7dOQ9jn4OFmclBOYV9fYJ
         BesWaDcOtrgfHPmKu2aKGsCW87sWu10Apf6O/QuWunScmOCkEAmGAYhq7aw1zfiZuTOl
         O7/7geb2sbqEihZIvlUS3aE/cNAiq6bTPkoMFeALeHK+re7pKg6whi/tDwh6O21PUpvG
         TifA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789059264; x=1789664064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L04gHjCTBFQDXGRIDlSdQjb0Hj0ou645OgkH0Fdl5tE=;
        b=tygvJHf5m12hJI4yD0+DHkPfi+I6nFBuCqD2glseR3KFbXn8m4l1UoDKcQ95CdLBnd
         teg5oh4toEUC3wKQlX+K+9fgQW7nigjZfY9xJt4tOIeS2smaToxzUqaKeUycoCXn4faR
         hR4Q74yrIa4RBxPMjNV3vxRDPuyAF99idnEpZ6bOXpmms/RWxPq8/X+MZZMXYSLFJVBk
         ybDw20HmTR4sgzmRPFJvos4mkTcgW/lxJ65C30koGJBOL2SzYOShfiVvsXN1GySdgD6C
         9LixwNkY+hZcSnoXZPWp/Ih86g2k5eBF2REjOzZUY4mbQpA25LyfeH1I1rXz68erNmNW
         1Yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789059264; x=1789664064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L04gHjCTBFQDXGRIDlSdQjb0Hj0ou645OgkH0Fdl5tE=;
        b=JK4mwKO29uji8rOxHsSA5zp4IIUCZoE/bPmGcu9ofYgqv8Vaz2uZQi49RriHwwYCzR
         U2VXsoI2S9sLsp4/3j+idPBjC+lxcIA7PI3qLoMuQ23197ITj0r6EUT3HxR36TvUS2Gf
         srSBFgsDmAaihJno4V2/ma4zLDYwNxeANPBf8f+t+jQm2nVM7OEjFLN3KAyhjjew9uAi
         I3+eTnRzcnl5iPkHLoNMRwef0sA9olRGOcm9Hjm2rlAFfDsiWUS5kyQg5tgJqbQZCZhG
         IWzWgFnI+LIo/Qfjr/AH0vW+kX6AKXQEyuXQ8aYs4cxcTWJh6d+nYGHZfoTT3/rlI/ub
         FdZA==
X-Gm-Message-State: AFuF++l5+/gu1YCEnYbQiRWsHVvaPU7GG5Ja4EMZgjw5HpqlOemGs7Y6
	5b/lzKJ/zoIVEiQej2rB3CAohUSwBDPee68zAEPJRVwndG8iVrG1nRhsN15bzlDegpNtC3AfR65
	NCmntDZ0RfDZOX40ezw5XaGe2JqJ5aWSXkbNVVSNGgy780dtldPWrNDUl
X-Gm-Gg: AYBFou0JpK7rneN4IQvY8ppNCxcWFMlWs3sXE3Hv16/M5oHqPG33jurW4BSgoMNKSrc
	mcL7SwLDXqBQ0PywEOm8RpaD7/YW7tKvx+baJK2orEamiNqfG/PodT/+tfetzuysHMCBf21njyv
	6znuWFE2qIHND61GR1eaawBomVbXCrZ/wKefanOUp/KnPSUdegcuz9VmAfz6d9/npkSW2Ubqfn3
	B4t+8yoiWymibNRy4oaM2DXYvHmDcq2SjIhJBFI81u3cTnhdq0rs34SuabFflIr2+Izh0JYpUSR
	GndHI5cZLZHn1FWSgiA6hUhwIDrOk76DLBqXMb6HQlBLCXgjF/sjGH08RSvlUiqxHHFV8OB5pzl
	j7r2PvmFwJA==
X-Received: by 2002:a05:6a20:6f8c:b0:3d3:ae0f:5269 with SMTP id
 adf61e73a8af0-3da3a15c001mr67239184637.21.1789059264027; Thu, 10 Sep 2026
 09:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com> <20260910162343.4092060-7-elver@google.com>
 <20260910163446.647251F000FF@smtp.kernel.org>
In-Reply-To: <20260910163446.647251F000FF@smtp.kernel.org>
From: Marco Elver <elver@google.com>
Date: Thu, 10 Sep 2026 18:53:46 +0200
X-Gm-Features: AcwNN1XQVMxlxNRQ2rDJ4hYkHistM0-b8j3ztCWHp9GpdQyKNVbDwqVUbza8x-Y
Message-ID: <CANpmjNP-0JLRuabbZoC9vkB7RTuQZAuJFHx1VOpJWRL0LuLCGQ@mail.gmail.com>
Subject: Re: [PATCH RFC 06/10] KVM: Add basic lock context annotations
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Sept 2026 at 18:34, <sashiko-bot@kernel.org> wrote:
[...]
> [Severity: Low]
> Does using container_of() inside a lock annotation attribute cause capability
> expression parsing errors?

Sometimes, but not in this instance. It's been tested.
