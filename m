Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC353DDDC4;
	Tue, 30 Jun 2026 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851547; cv=none; b=LCoihGpBL6J9yHpBh+W4YxUelND5CwOq0k1j8EKsP/3FHd/7o4huPUvHrIqirQW1+zB6w/ffFkbiem6AtBtQL8yTwQP4cbsZ72lsco7xbzfE3hVO4qlJHumdXX0gyqr+6cFnjsZhUoCNi7KqvymDC5t1+eBDP1h34Rez2JHRT3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851547; c=relaxed/simple;
	bh=+0vnvc0Lj/Of1cM+Yk8+OLr0KRKRO9Qc9+jopixFTfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PDDDx60mkNEab9TI5FWGRsRGFn2pj1HhYYpALKwnvcM8946YCTw0GGzXoozLm0F4gD3+ej4UKKxkUHJ0tpXyuNIzz35gFNVvEaAj0+WG9prQ8aYP0Vurg39ATldgLmTF10X5uTondf3EKmsZMRECERby3ZeUbpFX2sCSkiwz/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLrtswsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLrtswsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1461F000E9;
	Tue, 30 Jun 2026 20:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851545;
	bh=Ee0DW3u1OlD5/tDh+LJKu7ztlAs2aVA5k16PIo1KX+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GLrtswswueibf9TbwxLG6RHEqxAXwDHnvwO5ikdxKbEytrpbwQyitN4Uv1eEAwlII
	 9lIjqZlU6blDHghNITxhoN3THzQFzGDxNUEO+IZAku+1ru0DXcph8LUYvRY29EUn+E
	 pDl94gc4wPHNG9zMOre3lkVksmZg4pC9D3Kqa2+V6u0jqpOtOWdgSvYz3Zlwh4DAMX
	 A1xkZTXFngUtdcl1ULhF1BGHWeW6+OFxYlfiLVdkLkppuJCCX7XOIrGtrVItvTnzFq
	 iVaYG/ciGMJpaIpn258ajMjqDZCRNBx45O7LtOBMwY8AJ4QCQOF2wNHvpR33HwQ9pf
	 v+BhNfIHpoTEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B11393A951;
	Tue, 30 Jun 2026 20:32:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178285152938.267316.4321290266039198269.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:09 +0000
References: <20260628182052.951760-1-avkrasnov@rulkc.org>
In-Reply-To: <20260628182052.951760-1-avkrasnov@rulkc.org>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, bobbyeshleman@meta.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, rulkc@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 Jun 2026 21:20:52 +0300 you wrote:
> Logically it was based on TCP implementation, so to make further support
> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
> this way, patch also adds handling case when 'msg_ubuf' is already set.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
> ---
>  Changelog v1->v2:
>  * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>    already added.
>  Changelog v2->v3:
>  * Update commit message.
>  * Remove one empty line.
>  Changelog v3->v4:
>  * Update commit message.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] vsock/virtio: rewrite MSG_ZEROCOPY flag handling
    https://git.kernel.org/netdev/net-next/c/f456c1922c49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


