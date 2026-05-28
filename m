Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3274D3EFFB3
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973208; cv=none; b=JIUZAd10rDn+NewOLVajnoq+s/ikpYdZ/PVbGNhAWR1nGHHzZ3AOwwvAb0rZaYY2ARhG9LF/raqsIU98M1expt8anDJGihcOrM9xfqPAg3sRznQzv4TBjtwFH0GBJP2IcDHQ7z+qC+16/x3ALLniTTtB6d3anyh/J/ulT61/wNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973208; c=relaxed/simple;
	bh=i+YIvFhG1E4BxRnoXAwGqifvPcifRpxQCwZ6WTEikDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MvAjo8/hrW2N5ms6qeF9gM2loIr6asmpTsQXLCOy+KwoJ4bc/5ltz/U8jf/QSroJ4lGQoka3YfG3dW5fojgilvRQ/nKlX/+5tNFPU0+eBvMo28YfkOribFmKmyQeHm9yciggrpiQOLzHD3g4RUdYWE8yO2imjr83qzRtwN0iqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw+djJ3k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw+djJ3k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7ABB1F00A3A;
	Thu, 28 May 2026 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779973206;
	bh=GC4dTs7KtQtSKLSO0VnfACFd0y+dWw0dpVHMn2mL+pg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bw+djJ3krDDCP0jtaCtgKM/+sR+hKLTE/igfgG69cWOHqHuDNylr7lRI3RKx2ELSF
	 yBFtdkLS/GITDXtu+EXizAkzp20UHHrq5WaqqyOHLDACfQjbtv7NVMXBElCi1TrzOz
	 W6pFacZJ69Ajg7YTRqUpG6adFb59RXRA6XbAHsl14UTtcH6lTlvQgMlF0oByZKz1Ln
	 YS7UY+djJFd/TMY+7rDHpFr+iGvGRVHIt0ljybUPH+nC3chTNBm810qE+MRRaQPU5Y
	 VfzKACOgKUFdKuJxQBgI+2FG2nERrQtuniLjQSHL264EHk/YJQ4vVa74leG7SpRY1L
	 jd76FE7mim6MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] KVM/x86: Return -errno instead of "1" for
 Hyper-V related MSR emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528113605.267111-4-jgross@suse.com>
References: <20260528113605.267111-4-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 13:00:05 +0000
Message-Id: <20260528130006.B7ABB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning negative error codes instead of `1` from KVM MSR handler=
s causes KVM to abort the VM execution instead of injecting a #GP exception=
, allowing unprivileged guests to trivially crash the host VMM.
--

commit 868e38a1726825f4fe428f84907ee4e517306725
Author: Juergen Gross <jgross@suse.com>

KVM/x86: Return -errno instead of "1" for Hyper-V related MSR emulation

This commit changes the emulation code of Hyper-V related MSR registers to
return a negative errno value instead of a literal "1" when signaling an
error.

> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 4438ecac9a89b..809752a6d0ac5 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -167,7 +167,7 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *s=
ynic, int sint,
>  	 * allow zero-initing the register from host as well.
>  	 */
>  	if (vector < HV_SYNIC_FIRST_VALID_VECTOR && !host && !masked)
> -		return 1;
> +		return -EINVAL;

[Severity: High]
Is it safe to return negative error codes like -EINVAL here?

Looking at __kvm_emulate_wrmsr(), if kvm_emulate_msr_write() returns a
negative value (r < 0), it skips complete_emulated_msr() and directly retur=
ns
the negative value.

This negative return value bypasses #GP injection and propagates up through
the VM exit handlers to vcpu_run(). The KVM_RUN ioctl then fails, which
causes userspace to treat it as a fatal hypervisor error and abort the VM.

Could this allow an unprivileged guest to intentionally crash the VM by
writing to an affected Hyper-V MSR?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528113605.2671=
11-1-jgross@suse.com?part=3D3
