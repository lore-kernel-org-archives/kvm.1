Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1244102D
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135058; cv=none; b=mlZfwDHRJRcDUgl34EHb7mSzcYH/KoNlvxAxAAN3X/wk/u0dsKJL6WK3SkF1iVuWcMBafc9t7nDM2IOMnJGdsImm0xPqt315QX4o6UcU4ecQRzseGd36avoMXtQQMO46Fhv81cIkKRpSEj4M8Vnq3LuUoXyYAp47tlNptKYIh6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135058; c=relaxed/simple;
	bh=3pGeJe8ZyLVjcj+wo9fN8jM2Kp5+vJsl8vW3HM18/mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXE8PuIDd+MP1F8uIL6UydM1ZJZsiSebFDOUfXVFe4SLfSPKs9LQx6vc7PgxE23Vck4crt1EYpFhdaooAm+4w0ruyeGK2dywU1zi2vyxFjvuEndbX4ruCTrIUa3VuTBaOXiDJRSaVk6guR/XYcpXj6jy1i/tbMLjxheQq72xfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dp3luMXq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwGpMQbb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dp3luMXq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwGpMQbb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773135054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQE2TtbxQLn2XgnkFBUeE9JrlSwbGecE6X9gUERkTLU=;
	b=dp3luMXq6kAnn7awmDAejiQwJHm0QI8lkk346nsN2X8Y41CZg60hTrDKL6noXnANy+Qrr5
	dyYF1ltqryWn5sxgquHkq/PvZl1FF7Db8O/nc+SzNKMQeGhANMoWaQT8ze9fXZ1QwRWK4M
	cv08M/4yKu6CI1hnsM64LIG5iVAI5Co=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-r3uNhLNUORSIM9_zsiZMZA-1; Tue, 10 Mar 2026 05:30:53 -0400
X-MC-Unique: r3uNhLNUORSIM9_zsiZMZA-1
X-Mimecast-MFC-AGG-ID: r3uNhLNUORSIM9_zsiZMZA_1773135052
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439c794ec8eso6916497f8f.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773135052; x=1773739852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQE2TtbxQLn2XgnkFBUeE9JrlSwbGecE6X9gUERkTLU=;
        b=LwGpMQbb3Kp7QU14H0zLPy84gQZuVU0cXyZhKcygf/2DKM0eEPZJ3i+RS4UigMF46O
         rtDuVpK7tSESvh0maAF7CKggQStxpmzPJzpLrv+VO8aAq4Ioi80u/6wDv6C9AqbMjxTJ
         vV6dVwv3SpuPVzZtvkPGtpJSQkcPoWzVjqjg7OZXgOAUDymHLMVtUa82n+8cRuZcW56/
         3Y+FrJ1k7TLkjKSaOpigH9FZkMU1VLsIrCCdUtrxl9Acz4SjjsfoGhsZyMu+SaTwXqQJ
         XWhmhLXGq08G8QtkgwMHtes9mkSp8mBtLZWPu2M8LxwDbDQZYcNQauszzJ7+OK1vkrf7
         404A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773135052; x=1773739852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQE2TtbxQLn2XgnkFBUeE9JrlSwbGecE6X9gUERkTLU=;
        b=TkBN/dODCitT9GLLfrOkFJAaqD2gS5UNmCbg7ZsM8Sxrfo/+KTOaXKU1WXFohRNz2N
         mj8p96dYNrhsfBeV6A4tqHisF2kBKFS41FdDAeNQEmGNFkvFYTJmun339TaLADtnBNLj
         llEM/o/00Mbam+F0O8iS1p9RL9zs2hfKkZVEgKCweh4+jMykSY2k3rsaxfSarpwYYat0
         ALfpUhv+KlrjH1Zg156VTQDommjTAlFZ7LNjsKt0NKVL90c6R2W9DilTsPHt6XME3U1C
         Qg6F0Ocv4q+4gjgZlvk3zixyuZG1VL5qMgKGoKPVKQTWnSHU7is9/gseFusr4tXpPqWX
         G8Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW7sZCG9/ULZbl+I04HZRmanaXx60iT/HFzqrisUtne1Ox6SX4Z3OXshZJ4gkcHMjc3Ah0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5mgHye+sik6SIj7WiganB5MPNzh0dGafiIiE+VoeSsekT5w3B
	UDIuhYsC07SDkJzxyQgrNOsQNuMAbfyEazEhSrVCO9uExSgi7MzrTaVvbhcf+3hpLXbu5kfRLOm
	fLX03jSpf2X2pcjsShj2ECHJnqWg8DOGdclKAMyOdF6ATb/R4/Hwp8g==
X-Gm-Gg: ATEYQzxykUi4zs+Lfhf5fVQx9VCrGRBrhIuC9EOK12+kSnfkDpeSYILQZYBhW8DPi3x
	GOPWh95i+misgV/qIvazAcYlOOJ/dvkqdRqb2Ax0djU9sJU1I5X3Sn0PbzY2NqaQtcJjGS+HhZo
	ScP9Rf79ZafPOSLp/e79YUOmrWOhnRl8Dk7CtGUHsOnVGFTxPfjZu6IGNsNAi+saK3B05PurSiO
	Lf8sVV+rBhtFPRc0paHHhl1bwZPGwN6hhkoOGqXvymUmjlvytFeQLsT9C4C2xd9n4BmuAy1a6BG
	OeNAq4Jn2bBvm3dwCGesfM0e0ioZDHTNWVNG5A/6/w+q7LLuuMUepEWqV7mLESxLUWq6THhhhgQ
	HWyL/xkowByCm4bjTUID+oMokyvsX5sWVdeNvs2rf44s+5oQKmgNnIU63
X-Received: by 2002:a5d:64c9:0:b0:439:b440:b8b5 with SMTP id ffacd0b85a97d-439da86f760mr24469776f8f.43.1773135051996;
        Tue, 10 Mar 2026 02:30:51 -0700 (PDT)
X-Received: by 2002:a5d:64c9:0:b0:439:b440:b8b5 with SMTP id ffacd0b85a97d-439da86f760mr24469701f8f.43.1773135051364;
        Tue, 10 Mar 2026 02:30:51 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae57c05sm32133063f8f.39.2026.03.10.02.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 02:30:50 -0700 (PDT)
Message-ID: <8ae37965-ddc8-4ab0-aa95-0de17edf1a3e@redhat.com>
Date: Tue, 10 Mar 2026 10:30:49 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] vsock: add G2H fallback for CIDs not owned by
 H2G transport
To: Stefano Garzarella <sgarzare@redhat.com>, Alexander Graf
 <graf@amazon.com>, mst@redhat.com, kuba@kernel.org
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Bryan Tan <bryan-bt.tan@broadcom.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>, nh-open-source@amazon.com,
 syzbot@syzkaller.appspotmail.com
References: <20260304230027.59857-1-graf@amazon.com>
 <aalQditGLRMrlyV7@sgarzare-redhat>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aalQditGLRMrlyV7@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/26 10:51 AM, Stefano Garzarella wrote:
> On Wed, Mar 04, 2026 at 11:00:27PM +0000, Alexander Graf wrote:
>> When no H2G transport is loaded, vsock currently routes all CIDs to the
>> G2H transport (commit 65b422d9b61b ("vsock: forward all packets to the
>> host when no H2G is registered"). Extend that existing behavior: when
>> an H2G transport is loaded but does not claim a given CID, the
>> connection falls back to G2H in the same way.
>>
>> This matters in environments like Nitro Enclaves, where an instance may
>> run nested VMs via vhost-vsock (H2G) while also needing to reach sibling
>> enclaves at higher CIDs through virtio-vsock-pci (G2H). With the old
>> code, any CID > 2 was unconditionally routed to H2G when vhost was
>> loaded, making those enclaves unreachable without setting
>> VMADDR_FLAG_TO_HOST explicitly on every connect.
>>
>> Requiring every application to set VMADDR_FLAG_TO_HOST creates friction:
>> tools like socat, iperf, and others would all need to learn about it.
>> The flag was introduced 6 years ago and I am still not aware of any tool
>> that supports it. Even if there was support, it would be cumbersome to
>> use. The most natural experience is a single CID address space where H2G
>> only wins for CIDs it actually owns, and everything else falls through to
>> G2H, extending the behavior that already exists when H2G is absent.
>>
>> To give user space at least a hint that the kernel applied this logic,
>> automatically set the VMADDR_FLAG_TO_HOST on the remote address so it
>> can determine the path taken via getpeername().
>>
>> Add a per-network namespace sysctl net.vsock.g2h_fallback (default 1).
>> At 0 it forces strict routing: H2G always wins for CID > VMADDR_CID_HOST,
>> or ENODEV if H2G is not loaded.
>>
>> Signed-off-by: Alexander Graf <graf@amazon.com>
>> Tested-by: syzbot@syzkaller.appspotmail.com
>>
>> ---
>>
>> v1 -> v2:
>>
>>  - Rebase on 7.0, include namespace support
>>  - Add net.vsock.g2h_fallback sysctl
>>  - Rework description
>>  - Set VMADDR_FLAG_TO_HOST automatically
>>  - Add VMCI support
>>  - Update vsock_assign_transport() comment
>>
>> v2 -> v3:
>>
>>  - Use has_remote_cid() on G2H transport to gate the fallback. This is
>>    used by VMCI to indicate that it never takes G2H CIDs > 2.
>>  - Move g2h_fallback into struct netns_vsock to enable namespaces
>>    and fix syzbot warning
>>  - Gate the !transport_h2g case on g2h_fallback as well, folding the
>>    pre-existing no-H2G fallback into the new logic
>>  - Remove has_remote_cid() from VMCI again. Instead implement it in
>>    virtio.
>>
>> v3 -> v4:
>>
>>  - Fix commit reference format (checkpatch)
>>  - vhost: use !!vhost_vsock_get() instead of != NULL (checkpatch)
>>  - Add braces around final else branch (checkpatch)
>>  - Replace 'vhost' with 'H2G transport' (Stefano)
>> ---
>> Documentation/admin-guide/sysctl/net.rst | 28 +++++++++++++++++++
>> drivers/vhost/vsock.c                    | 13 +++++++++
>> include/net/af_vsock.h                   |  9 ++++++
>> include/net/netns/vsock.h                |  2 ++
>> net/vmw_vsock/af_vsock.c                 | 35 ++++++++++++++++++++----
>> net/vmw_vsock/virtio_transport.c         |  7 +++++
>> 6 files changed, 89 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
>> index 3b2ad61995d4..0724a793798f 100644
>> --- a/Documentation/admin-guide/sysctl/net.rst
>> +++ b/Documentation/admin-guide/sysctl/net.rst
>> @@ -602,3 +602,31 @@ it does not modify the current namespace or any existing children.
>>
>> A namespace with ``ns_mode`` set to ``local`` cannot change
>> ``child_ns_mode`` to ``global`` (returns ``-EPERM``).
>> +
>> +g2h_fallback
>> +------------
>> +
>> +Controls whether connections to CIDs not owned by the host-to-guest (H2G)
>> +transport automatically fall back to the guest-to-host (G2H) transport.
>> +
>> +When enabled, if a connect targets a CID that the H2G transport (e.g.
>> +vhost-vsock) does not serve, or if no H2G transport is loaded at all, the
>> +connection is routed via the G2H transport (e.g. virtio-vsock) instead. This
>> +allows a host running both nested VMs (via vhost-vsock) and sibling VMs
>> +reachable through the hypervisor (e.g. Nitro Enclaves) to address both using
>> +a single CID space, without requiring applications to set
>> +``VMADDR_FLAG_TO_HOST``.
>> +
>> +When the fallback is taken, ``VMADDR_FLAG_TO_HOST`` is automatically set on
>> +the remote address so that userspace can determine the path via
>> +``getpeername()``.
>> +
>> +Note: With this sysctl enabled, user space that attempts to talk to a guest
>> +CID which is not implemented by the H2G transport will create host vsock
>> +traffic. Environments that rely on H2G-only isolation should set it to 0.
>> +
>> +Values:
>> +
>> +	- 0 - Connections to CIDs <= 2 or with VMADDR_FLAG_TO_HOST use G2H;
>> +	  all others use H2G (or fail with ENODEV if H2G is not loaded).
>> +	- 1 - Connections to CIDs not owned by H2G fall back to G2H. (default)
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 054f7a718f50..1d8ec6bed53e 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -91,6 +91,18 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
>> 	return NULL;
>> }
>>
>> +static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
>> +{
>> +	struct sock *sk = sk_vsock(vsk);
>> +	struct net *net = sock_net(sk);
>> +	bool found;
>> +
>> +	rcu_read_lock();
>> +	found = !!vhost_vsock_get(cid, net);
>> +	rcu_read_unlock();
>> +	return found;
>> +}
>> +
>> static void
>> vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>> 			    struct vhost_virtqueue *vq)
>> @@ -424,6 +436,7 @@ static struct virtio_transport vhost_transport = {
>> 		.module                   = THIS_MODULE,
>>
>> 		.get_local_cid            = vhost_transport_get_local_cid,
>> +		.has_remote_cid           = vhost_transport_has_remote_cid,
>>
>> 		.init                     = virtio_transport_do_socket_init,
>> 		.destruct                 = virtio_transport_destruct,
>> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> index 533d8e75f7bb..4e40063adab4 100644
>> --- a/include/net/af_vsock.h
>> +++ b/include/net/af_vsock.h
>> @@ -179,6 +179,15 @@ struct vsock_transport {
>> 	/* Addressing. */
>> 	u32 (*get_local_cid)(void);
>>
>> +	/* Check if this transport serves a specific remote CID.
>> +	 * For H2G transports: return true if the CID belongs to a registered
>> +	 * guest. If not implemented, all CIDs > VMADDR_CID_HOST go to H2G.
>> +	 * For G2H transports: return true if the transport can reach arbitrary
>> +	 * CIDs via the hypervisor (i.e. supports the fallback overlay). VMCI
>> +	 * does not implement this as it only serves CIDs 0 and 2.
>> +	 */
>> +	bool (*has_remote_cid)(struct vsock_sock *vsk, u32 remote_cid);
>> +
>> 	/* Read a single skb */
>> 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>>
>> diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>> index dc8cbe45f406..7f84aad92f57 100644
>> --- a/include/net/netns/vsock.h
>> +++ b/include/net/netns/vsock.h
>> @@ -20,5 +20,7 @@ struct netns_vsock {
>>
>> 	/* 0 = unlocked, 1 = locked to global, 2 = locked to local */
>> 	int child_ns_mode_locked;
>> +
>> +	int g2h_fallback;
>> };
>> #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 2f7d94d682cb..50843a977878 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -545,9 +545,13 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
>>  * The vsk->remote_addr is used to decide which transport to use:
>>  *  - remote CID == VMADDR_CID_LOCAL or g2h->local_cid or VMADDR_CID_HOST if
>>  *    g2h is not loaded, will use local transport;
>> - *  - remote CID <= VMADDR_CID_HOST or h2g is not loaded or remote flags field
>> - *    includes VMADDR_FLAG_TO_HOST flag value, will use guest->host transport;
>> - *  - remote CID > VMADDR_CID_HOST will use host->guest transport;
>> + *  - remote CID <= VMADDR_CID_HOST or remote flags field includes
>> + *    VMADDR_FLAG_TO_HOST, will use guest->host transport;
>> + *  - remote CID > VMADDR_CID_HOST and h2g is loaded and h2g claims that CID,
>> + *    will use host->guest transport;
>> + *  - h2g not loaded or h2g does not claim that CID and g2h claims the CID via
>> + *    has_remote_cid, will use guest->host transport (when g2h_fallback=1)
>> + *  - anything else goes to h2g or returns -ENODEV if no h2g is available
>>  */
>> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>> {
>> @@ -581,11 +585,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>> 	case SOCK_SEQPACKET:
>> 		if (vsock_use_local_transport(remote_cid))
>> 			new_transport = transport_local;
>> -		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>> +		else if (remote_cid <= VMADDR_CID_HOST ||
>> 			 (remote_flags & VMADDR_FLAG_TO_HOST))
>> 			new_transport = transport_g2h;
>> -		else
>> +		else if (transport_h2g &&
>> +			 (!transport_h2g->has_remote_cid ||
>> +			  transport_h2g->has_remote_cid(vsk, remote_cid)))
>> +			new_transport = transport_h2g;
>> +		else if (sock_net(sk)->vsock.g2h_fallback &&
>> +			 transport_g2h && transport_g2h->has_remote_cid &&
>> +			 transport_g2h->has_remote_cid(vsk, remote_cid)) {
>> +			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
>> +			new_transport = transport_g2h;
>> +		} else {
>> 			new_transport = transport_h2g;
>> +		}
>> 		break;
>> 	default:
>> 		ret = -ESOCKTNOSUPPORT;
>> @@ -2879,6 +2893,15 @@ static struct ctl_table vsock_table[] = {
>> 		.mode		= 0644,
>> 		.proc_handler	= vsock_net_child_mode_string
>> 	},
>> +	{
>> +		.procname	= "g2h_fallback",
>> +		.data		= &init_net.vsock.g2h_fallback,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_ONE,
>> +	},
>> };
>>
>> static int __net_init vsock_sysctl_register(struct net *net)
>> @@ -2894,6 +2917,7 @@ static int __net_init vsock_sysctl_register(struct net *net)
>>
>> 		table[0].data = &net->vsock.mode;
>> 		table[1].data = &net->vsock.child_ns_mode;
>> +		table[2].data = &net->vsock.g2h_fallback;
>> 	}
>>
>> 	net->vsock.sysctl_hdr = register_net_sysctl_sz(net, "net/vsock", table,
>> @@ -2928,6 +2952,7 @@ static void vsock_net_init(struct net *net)
>> 		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
>>
>> 	net->vsock.child_ns_mode = net->vsock.mode;
>> +	net->vsock.g2h_fallback = 1;
> 
> My last concern is what I mentioned in v3 [1].
> Let me quote it here as well:
> 
>      @Michael @Paolo @Jakub
>      I don't know what the sysctl policy is in general in net or virtio.
>      Is this fine or should we inherit this from the parent and set the
>      default only for init_ns?

AFAICT, there is no geneal policy; depending on the specific value it
should be inherited or be available to configuration on per netns case.

Usually the inherited values are constraints to system-wide resources,
i.e. max memory allocated.

In this specific case I feel like allowing per netns configuration is
correct.

/P

