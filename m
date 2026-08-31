Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FB3A3E76
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160993; cv=none; b=KKIs0JqjJO5TVP1m18AEHuNtd/O0UaBgKcfU5gZdfIaTpjJsl2MOpt/L2NxbSCNvcmlEHiry+3tsiVgzLY6545MS68Wb4FB/JpMe1fdzJ5fdvLpvlq0w2fGVNSqMYNiAkN9PGQ3VfYNOHuBixSAFwHGotKTM1NqSe66K5LWX6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160993; c=relaxed/simple;
	bh=9HIaajRUdeYd/l/oGPuA23yJ5BuAG+q3faAztOdeL2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fRrJ/uIjPU5ropzKMW+ARty3X0fIJeRuthngCW9PyJfZexZ62jF7nTClqhlfwnCieeoOPgxjjCw5awukNnNf8N/ct75rQgW8g+qIdg2hoZU6FsVILFgH1OO5E7UKIRJz9RpUYsxw+cNAro6oFMgwZB8RM5DA13w0nYkBzwW/yp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLFEQNdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLFEQNdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2DA1F000E9;
	Mon, 31 Aug 2026 07:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788160992;
	bh=c31myHV4ofCbqYDu0tkmDYy535mvQx+jLOEYFpZQx6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KLFEQNdQOGpYlq9w+EQtpqRYwDLeC19AZinoUyj2zKvYE5OFld3ldWgnAo25CKLb0
	 JbOgTvTfyDbcxhv5zUODhGA6qu/K8OStCCQJEZ9y8YrTtAiuN9GnOMZlE12HauSELn
	 3HYsMGOdFZeey+YSU2dssslTWrA2gZvPmp7tKpCXKYS1WCMHe8aYyuDTAAmQ/KbRcH
	 oQbVrdeJ7sC7YM583huGYOiR+tJnOOFAwlRxpZrpra0xeKI9POTwGZHFTT7/TDm738
	 cSW59uDORv2c0iY5apV42rTxJVW8P25MzPQ+Tu/FQKz1fibEDFMeuRVSop7VkKWH7/
	 7BxHG/nI+to8A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional
 KVM_CAP_LIVE_MIGRATION and KVM_MIGRATE_CMD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tony Lindgren" <tony.lindgren@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260831071304.762939-3-tony.lindgren@linux.intel.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:23:11 +0000
Message-Id: <20260831072311.CF2DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The 'flags' field in the new 'struct kvm_migrate_cmd' UAPI is not =
validated to be zero.
--

commit b50bc10fe65ad9a54c9b979c445505e5baf76592
Author: Tony Lindgren <tony.lindgren@linux.intel.com>

KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION and KVM_MIGRATE_CMD

This patch introduces the KVM_CAP_LIVE_MIGRATION capability and the
KVM_MIGRATE_CMD ioctl. These additions allow KVM to configure hardware-spec=
ific
live migration functions, which is necessary for confidential guests like T=
DX.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index afcac1042947a..7064fd709e56d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -7614,6 +7617,28 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned =
int ioctl, unsigned long arg)
>  		r =3D kvm_vm_ioctl_set_msr_filter(kvm, &filter);
>  		break;
>  	}
> +	case KVM_MIGRATE_CMD: {
> +		struct kvm_migrate_cmd cmd;
> +
> +		if (!kvm_x86_ops.migrate_cmd ||
> +		    !kvm_x86_call(cap_live_migration)(kvm))
> +			return -ENOTTY;
> +
> +		if (copy_from_user(&cmd, argp, sizeof(cmd)))
> +			return -EFAULT;
> +
> +		if (cmd.reserved || cmd.buf.reserved)
> +			return -EINVAL;

[Severity: High]
Does this code also need to validate that the new flags field is zero?

If uninitialized memory or garbage is passed by userspace in cmd.flags, it
will currently be silently ignored. When a future kernel introduces a new
flag, old userspace applications passing uninitialized flags will inadverte=
ntly
enable it, which could permanently break backwards compatibility.

> +
> +		r =3D kvm_x86_call(migrate_cmd)(kvm, &cmd);
> +		if (r > 0)
> +			r =3D -EIO;
> +
> +		/* Copy back also on an error to report a partially done command */
> +		if (copy_to_user(argp, &cmd, sizeof(cmd)))
> +			return -EFAULT;
> +		break;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831071304.7629=
39-1-tony.lindgren@linux.intel.com?part=3D2
