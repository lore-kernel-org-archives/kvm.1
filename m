Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690EC43DA2D
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979417; cv=none; b=cqGBTXtkp9FJHJ2gk0ZfWnL7pjkf+IIRbM92QlKz0stnIyAglIvmfZS+r38NU56J5qc5xzRM68AbkXBjF4T+pPfVmpR9DPGcDPoKoTVYhIkR6I7ReveHW1V5G4o6grbc7rsnzG+/7mD39EVRGU/tkqJxvjy66ZycfVHOOyE6DdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979417; c=relaxed/simple;
	bh=VgUis9s6Qpjfluu+1DI7P/hWgNf6BSkMHZzWmBjouEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SnoFq9xmUm9lngp3UGpwZz6ZNgDDo86IdsH9E/hVxvSdP4QVjX5Kcz3I/MSL2RkxE4FpULeOBnYpbFo2B58fZqe/gdz1zfszGaskdRyUVW2kWrhgenopsu6Ax5GdIy40gEaZ36yY6zZv0a8F+2s1Gz4SjXAI0nourvQzxPxCIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tUS2xhE4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUS2xhE4"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a6906e35fso104554b3a.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774979415; x=1775584215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBeMy8Rw/5TjXCLG+UKpazz3KysoPcTZt6O2J4Vg6kM=;
        b=tUS2xhE4G6sHOzS3dSEfRi88IwOQzU558/DD3p2JsuYOjcd776/U9PVI25VTBC4fo3
         kLiQ22ChBW3e3TMBI8j9/qoouqK5aPXkruqVz+OjvTT7MpLLSAwYLuQ2Qju+YGK5l8+5
         67WAJmGNsmcCeG6TeXyk+z/kS/9Wl7LB1cPH1MeaOROML/9ZlQ8PnfuDY1b1tV1sMgrM
         Low6kvgAPWNsKauJM7qqC47LD48YtE/lJ//V5RNoPhnU7ck3eecr7S0+EkCFo1NXu3oZ
         SqzjkM7hirh1nl9SG5CzmtGdAHOKkqSwZgQxiiklw7hgt3emG17C+Yj8JXb1GfLWs9fl
         d/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979415; x=1775584215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBeMy8Rw/5TjXCLG+UKpazz3KysoPcTZt6O2J4Vg6kM=;
        b=FmiP06ogY3LLPTk1tuLZKpNTYeSjt+/tz4MCwsY/nGYW8BsZkVzWX5UWX3Cjw1+tY1
         YYQ6FLnOpJA1KaCBZ/fxrYKvryj48qMtMaSPF6+8SiR/1wmEhmqJp/78F+Xoybd3E8jR
         AotbwBlheE5rGDh+R7CUJhKbkUjL76kZRynm9VazWkiUupSnYfyqJcLBW/ch1jcOVWfD
         pIM8L3az6SoNzH02Q8T7lGhMRz8ZYSDkg5kOIsdfoPePISplgHIrZyqSPMJi7wZoQoR/
         CnuxZ1T1q6AdWqiBz6yKrU2AoB++Bw9OPfmLp3Aep6Zu/5Y0Co+12z8IhTzNXtbQj8me
         uDqg==
X-Forwarded-Encrypted: i=1; AJvYcCVLUlCYkJYwnls+QROhq0k6hlGw++aOOwp9pXp60vPySc2meklIppm6uf25BHOKvPuPZjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbB/mmBl6rx56vYxBYS2oGej2ZGSGNV0IRKPi0/z4bwdzivCj
	r72TTTcTnf8MoU6y5GiXOqUrrZcIGD0ohWpPDjxK7Rhs+JjxFtZTcMahTcy9L4MhAUka6jadCKF
	9HXZbtA==
X-Received: from pfbg26.prod.google.com ([2002:a05:6a00:ae1a:b0:829:7b74:e1a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e97:b0:829:7a62:6a
 with SMTP id d2e1a72fcca58-82ceaadcfc0mr197450b3a.22.1774979414552; Tue, 31
 Mar 2026 10:50:14 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:50:13 -0700
In-Reply-To: <20260324-vmscape-bhb-v8-4-68bb524b3ab9@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com> <20260324-vmscape-bhb-v8-4-68bb524b3ab9@linux.intel.com>
Message-ID: <acwJVUeW9KoLft4d@google.com>
Subject: Re: [PATCH v8 04/10] x86/vmscape: Rename x86_ibpb_exit_to_user to x86_predictor_flush_exit_to_user
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	David Laight <david.laight.linux@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 24, 2026, Pawan Gupta wrote:
> With the upcoming changes x86_ibpb_exit_to_user will also be used when BHB
> clearing sequence is used. Rename it cover both the cases.
> 
> No functional change.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
