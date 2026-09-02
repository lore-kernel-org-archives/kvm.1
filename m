Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F21F5821
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308354; cv=none; b=ZRc15gEzmClNmX/kVCwCYqoc7vR96bmK3ESPtvovilzvBqlvjGYij+kW/R/+P+EOnflEuWEdeH+kGbvyKzhrtAiSQ0csxGzCnbTzie2cbDHkXuRisNyl9/YT9ERXTYAjGh389Yx0HUAguypzu6HJ1Vl1Q3lynmK3JXfuFrepkF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308354; c=relaxed/simple;
	bh=ZVMCpHFjCC/1cFP2Dsvos5quhskBkFcAciEaJfo13tE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HDFtecz39gk4mY2TKEoHu8t+H3eMzHTzjqA+pzESCO+KVCeRsVET7K82PoEsGO7fLX0Qd7CnTnCtyLJFVwQ5oFdWe8TJ7Psj5aut/F1ygHCokb1cGBS5koqIlb8r2OrO/UPwf8eqvxrXHPDX5ga8sluEqiDxiRJlhzvlDJHsf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWaYfswv; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWaYfswv"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84842381150so503999b3a.3
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 17:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788308351; x=1788913151; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ww1VJhw7gyphCHZq2wYpc50Hd6JBKjSP79u0OfvtMeM=;
        b=VWaYfswvhPIbPzGaqgho3BljY8HaChzcpktLqArJS1K9FqsrH3kD5I7eN3JfWkOi+L
         yQMdjt0kjK0gjG70Su7og5AENuDaQ4ZpMLNqzHkyRFU2Az1+ClaAEfU03isM7vnzjhLx
         yS7cofarFZtzosokYR2PqyC4k9vg3+Onr+xrrIGxL5u7GESBdbmOnNJmYcM1VOpKAw0g
         SvU9aPxuZ5xGMnWfsKfIy0fRs/yfbGXNvcly6QEftp7bjJ2fwCrkoY004Zj/T73fCEVW
         lhSIm9KK4TsLafZcig5hBx+8CK08ye0bRSlMjKmh6TpQ33QzjqrmK17wOpE6NhCFb7aC
         o4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788308351; x=1788913151;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ww1VJhw7gyphCHZq2wYpc50Hd6JBKjSP79u0OfvtMeM=;
        b=n7jdrozpa8JhN7KvgqZcTAgTpF7tm70dWwdCC8yuPmALtzw5QToKLUAUFyXRnBFaCy
         8cdRN7Beq4MI0xyIxO4ZK0HG11RsjUDojq+m0cUXdNwNSjbKr+rt8AZ7nvxZgUmd5Sqn
         B6aF6ollL1SEkA7vGNsra/5FgLJEGjYuFxvo82JSTxUmqS+uRWgPZ2tWiGE7sGGXHCCP
         3mKzMkI51nIUSSxYAmPlPQNkBg8+n7sHWSV08NWenLGweEATbGNR/BI2ZbeXDlToetdF
         eSpuwMBkXA5Lzr1CtJBDLSkZKYKnqugVo+fHkHNSRicdB8YrpaHjCTegbTUYtSEQO6xl
         PjZg==
X-Forwarded-Encrypted: i=1; AHgh+RquOSpCjDCI7rOnJPTQnhFyOW+UVunXDcvFcB+TN4wJ4RaWZxRyQUVoV6BEPj9dxFPutJs=@vger.kernel.org
X-Gm-Message-State: AFuF++ktkvVSaCyXfbHG387Kubr2xhgt5tHV3Dh9WwtHsqEq1iCs8rGH
	RyOImo0+trdbLv3KaMFCuRhZAICvhk8/AaWE8jYH1bOQLwKeeXIpoKX4WlWQMh493zXpiqfJyLg
	aw2dgHA==
X-Received: from pgct15.prod.google.com ([2002:a05:6a02:528f:b0:cc1:c07e:b53c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6004:b0:3d3:adbf:777f
 with SMTP id adf61e73a8af0-3d9afafc376mr1486082637.20.1788308351228; Tue, 01
 Sep 2026 17:19:11 -0700 (PDT)
Date: Tue, 1 Sep 2026 17:19:10 -0700
In-Reply-To: <20260730110524.2539316-2-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com> <20260730110524.2539316-2-ewanhai-oc@zhaoxin.com>
Message-ID: <apdrfkO8ALRz59yl@google.com>
Subject: Re: [PATCH 1/8] KVM: selftests: Add Zhaoxin (ZX) CPU detection support
From: Sean Christopherson <seanjc@google.com>
To: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Frank Zhu <frankzhu@zhaoxin.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 30, 2026, Ewan Hai-oc wrote:
> From: Frank Zhu <frankzhu@zhaoxin.com>
> 
> Add infrastructure to detect Zhaoxin CPUs in KVM selftests. Zhaoxin
> CPUs use vendor strings "CentaurHauls" or "  Shanghai  " and implement
> VMX-compatible virtualization technology.
> 
> Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  tools/testing/selftests/kvm/include/x86/processor.h | 7 +++++++
>  tools/testing/selftests/kvm/lib/x86/processor.c     | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index b161174ece45..9840b583877c 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -23,6 +23,7 @@ extern bool host_cpu_is_intel;
>  extern bool host_cpu_is_amd;
>  extern bool host_cpu_is_hygon;
>  extern bool host_cpu_is_amd_compatible;
> +extern bool host_cpu_is_zx;

Please spell out "zhaoxin", "zx" isn't intuitive for most of us (I keep thinking
it's a compression feature).

And do the same thing we did in commit 53b2869231d3 ("KVM: selftests: Add a flag
to identify AMD compatible test cases"), and add host_cpu_is_intel_compatible.
That should cut down on the number of checks on is_zhaoxin, and should help avoid
issues like the ones Sashiko pointed out.
