Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2D48664C
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727567; cv=none; b=B1vOegi9VJvoQlrCTsbxruMfc7AqIcX5opqnGLelDLiUgZbLbcpVH9GZrq6UrcySz4N6lDp27NTlDWAZySAXALH+xbBeOcq3HndNaprFhcsdKKTmCIrwdWdEEzJ8EQIyGEopxwiG17Bn7J2Kb3S7jomMw4Ml2e4X7FL+MwiBj4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727567; c=relaxed/simple;
	bh=3y/CgvSV9/spB42H58eBm2iNL8x9g4lCKrpuNOhwQHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FCQMYYZqLdb6WfJgP4lrZBx7eQUJ2tP7viprCTdQoRvfl8iDQjizfJqzqoFkcrwlkwWGuiPvF+7OlpcBABseVP2IhThPmNwT+UQH4l03ErO+H1MadTUluim5qeDatKV6K1HGU/DCok0Epyq3J+NaJm4sg0rnU9vzL3t+MdMrnC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAB5u3hP; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAB5u3hP"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so1535801a12.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 10:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786727565; x=1787332365; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWjdemJZnftyld6YOAQ6Wsvdeomv2P2Ul7Km+qAcNvM=;
        b=eAB5u3hPrtRciXcyrpxYbBZt6v/qoRH5PDK72ABVTdZBAMw2idcWpFLhO49cKO4S2S
         oTRkytQjo0x80XRuVwO4+EBtzn2+8qjEkhxPrFqHqiu1WuszDvsTvdw8OaZXGhS651V6
         53RLYHie+o4W/gSwHNzI9q7kmQLRio8ADBIF+bYnvaogfSWY2r1WZjo/rC6bibU3e2Ig
         qJNUEXwEiHfFvgWGui6q0tUZjtO6a3CHrL/mvZsBk+5fD3lI/XGWDyTgOXGYsrGqrXiE
         wL7302XxqlzOrwU4XePj0DvGgrbThyUPtk3GygMLqrOqDodB9ug7xVyZGkY8g7vlteLE
         uZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786727565; x=1787332365;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWjdemJZnftyld6YOAQ6Wsvdeomv2P2Ul7Km+qAcNvM=;
        b=g2J7YzVNKzYIqlyzgHvrxZih9ofWyqYFNgR1lTH+N20XC1CRuOg1WZIUn8r9Bvs4Sv
         Jqu1yzVfwo0FK4KlLxidrR3I4F3h6XEE444I2uNsNbSGzgi/FhpN4qmYjToGPBptPaqo
         saDt4ftOoWn/Z0y7QmHauTuwlr/HI5Ef1JZtk6CoiJg/2WrrQUzfE7rTRLRDPTFl6nT+
         NL9n3BJgdSk6frlnjWQpiSOs0H/5UzPmd5+DH78+67+O5UejwJPOnOfDI+Curd5HF1TB
         gwo4J0JglhihkzU6UU35E/TCkxUjOEu+w4NiZKNsz8f2+hLoxv02qgRNRrzgK2/ACQNo
         akUQ==
X-Gm-Message-State: AOJu0YxIDVKqsd8AK1GDpOCWEKvsqmXqLEEPFogt7aLumokZ2B268+fY
	4aGV/ObwwEhuCM8MsuB8fW8yPuAl2OUYprWobwd7GGKgbun3F+FMv9qOWTF8wrAeAwLFskiAGdT
	zA556UA==
X-Received: from pgar27.prod.google.com ([2002:a05:6a02:2e9b:b0:cbe:d979:e9ce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3949:b0:3c3:8651:b317
 with SMTP id adf61e73a8af0-3cc71ced4d0mr7818747637.10.1786727565317; Fri, 14
 Aug 2026 10:12:45 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:12:44 -0700
In-Reply-To: <an9KM3Ye-GX7WggF@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814161129.2177118-1-seanjc@google.com> <20260814161129.2177118-4-seanjc@google.com>
 <20260814161950.136041F000E9@smtp.kernel.org> <an9KM3Ye-GX7WggF@google.com>
Message-ID: <an9MjA8JvHBipTv8@google.com>
Subject: Re: [PATCH 3/3] KVM: VMX: Rename posted interrupt prefixes from "vmx"
 to "vt"
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, Sean Christopherson wrote:
> I'll also add a blurb in the changelog for patch 1 to explain that keeping the
> vmx_ prefix is intentional so that vt_op() doesn't require a one-line forwarder
> when CONFIG_KVM_INTEL_TDX=y.

/facepalm

The callback is wired up directly, i.e. it can simply use a "vt" prefix.  IIRC,
I was playing around using vt_op() to address the wait_for_sept_zap issue and
forgot to revisit the change when I discarded that idea.
