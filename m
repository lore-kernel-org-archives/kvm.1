Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAED2FDC30
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476508; cv=none; b=mp6S6dZ8mOWv8iYFXadHLwAc+cpASc7VwndmQhyRTmbjN/TFuudvbjTB03n6dKL1HLM2H6wfcYsVllTEQBBw1SLF5ZkLNzQn/cVwwwnCIzSQotZ17Z2748FBsncbKc8q23Hie3bNFm/Dcl9+1vC6Pv1U0EjqIrD7QSr20pfJMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476508; c=relaxed/simple;
	bh=IB2xGe78if9pBOHK1rwqyrJ+kUaSUGKojkBquHLbgIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u9hzf2z49m+8Q2N5xdNSHtiaHqHsRiXY4XBzWtTHJuusPPvJteZMvwj1mYLk1nFrvbYCEg31A3Z+ULMAInTKKjPboDuW8tZBoi9nwks43YAtUy2uByT/zurCVM1PV73kHZV+hKBDq5wtMhXJ5sETY+yPtTcHfe6OhfXzr8KtgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjqqiYyq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjqqiYyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5351F000E9;
	Thu,  3 Sep 2026 23:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788476507;
	bh=JzvXorzTrGduI1v/Bthj3Zj+Go3Mg8IfvaCWX4IzbkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PjqqiYyqDICMEbwzvxqu6AWmRthR9jonoFNVMr4CU7fBrDu/5zvZ/md/IBeiBDayq
	 GUJ2L/aI0zg+xHjnP8O3/gcOnmchyuNURcxTQYbHt+0cw/XfxGLzACtIyCqedCRUWB
	 D+Wv/Mbo0Iaf79Ikx8eO5F2mmx45zqyZiA0cVtRMhMdBEorQNEWsyAP+2FE4T+N17z
	 d5KQu6bH8dq8eykR+KCanowuCyXWP487lrd5yJTETuh958EHeyObbbLTIGKrspVr+j
	 O7d5HMkmlokl8RqrFpIB83xx8ZmrRmZCO/9jq9s6j0PKDYfnAagkHIp+GswthBPs0D
	 iJdBF1l12DVvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/6] vsock: add
 IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 23:01:46 +0000
Message-Id: <20260903230146.DD5351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unreachable connections are forcefully closed without notifying th=
e transport, causing zombie connections on the remote host.
--

commit f3fdca73a2fc67941333bcc7521ccf2e755bdfaf
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS

This commit introduces an ioctl to assign a guest's vsock device to a
specific network namespace. When the device moves to a disallowed namespace,
existing sockets are reset to prevent unauthorized reachability.

Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 29cde17e08f31..ad11f0f56eb8a 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
[ ... ]
> @@ -710,6 +751,140 @@ bool vsock_find_cid(unsigned int cid)
[ ... ]
> +static void vsock_reset_unreachable_sock(struct sock *sk)
> +{
> +	if (vsock_g2h_net_reachable(sock_net(sk)))
> +		return;
> +
> +	sk->sk_state =3D TCP_CLOSE;
> +	sk->sk_err =3D ECONNRESET;
> +	sk_error_report(sk);
> +}

[Severity: High]
Does forcefully setting the socket state to TCP_CLOSE here prevent the
transport from notifying the remote host?

When the state is set directly to TCP_CLOSE, a transport's release function
(like virtio_transport_release()) may see the socket as already fully
terminated and skip sending a reset message (like VIRTIO_VSOCK_OP_RST) to
the host.

Since this ioctl can be triggered by a guest user with CAP_NET_ADMIN in the
init user namespace, could this lead to zombie connections accumulating on
the host hypervisor, potentially allowing a guest to exhaust host resources
because the host is never informed of the dropped connections?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-vsock-gues=
t-ns-v1-0-9995383e9a8b@meta.com?part=3D2
