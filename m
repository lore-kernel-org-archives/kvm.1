Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75236AB77
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184762; cv=none; b=mxFynuy6vQaq79TBliZAIj4O1ivKVTNwcvVckindp6b7OfQ/X9UjSSIXNAtAu5oWUQDZZI21N4Kyrxw7fz0QUOWhclloxtFvC69we2cycd8OYLQNbeE3g9dSopn6jY6iobVmn2WPuYDBxNceZp29s4x1vwO2ftZ9A6uusm9+ifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184762; c=relaxed/simple;
	bh=YiA1eEseDRCOb+C4MPisetZeRtex0Ar8vxo2COhJHQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2IsjUgm9oBlMIF0RISeq04T05fjcAZaKqnwn/aJ03dv4yGBdWHtCgvlbgXZmmcBoM0zhaMoh80pxl8PL9MTFtfHXuAgmBAnvZbDf2X57d2OmA74c5KAtHQr2YfwqvCGFry2u9qRlV5dHBZUeMJD4GcWlv2B7yFLKhw12G1F9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/g/ge06; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/g/ge06"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ee9ec26edaso131606085a.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778184760; x=1778789560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CufiyOMzWgsZjfa0uu9olo/GL0CEznYyMUEZlGLNhMU=;
        b=T/g/ge061pRx5t3ffnUhKYtUO1RKS8vcp/2PZ57Ge6G/H/wCYga5KeuVfgq4E/8WZj
         mqTxGJPqx0Vg9m/Q/tcgRtOMaca503DSeo1ZGJAZjrstg9VYO6MuHTyFdyQjw3ByD+XA
         P9Muo/iBBht1PhJdjiUfJABtnlwNlONhVlNNnVlNWnnUSjQKQSNA8S5kKGTKbeGwACBd
         QcmBXc1xlKiyJsDe1EG4sfjPcsTxbSAIOWXNtB3L7v/2AO2c4Wmnrs6xByPM0mFpBlAL
         rM9HL3Y0ubuZw1ZmmGLpodyBmSVbaNBlANnOXopMMh6NThpaktkZTSSOkoByIJYJ3GjM
         S9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184760; x=1778789560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CufiyOMzWgsZjfa0uu9olo/GL0CEznYyMUEZlGLNhMU=;
        b=K02ME4yKudTHyGUAtePO6p6X19nXCHwIkSJKY6JNBf9FNvlkIU91BfwLhJ3yzI1xcj
         +25UKbZtcEyt5SxEZ9+pbvbnBNkRfqb2PCesDrLn01D8vZetYg5zVAe6ZTMXoPVkxhF5
         gL4TxTU800ESOc9wfe6vWm2qo5X/dPYCPOtFOxsaGmGCO8sq5u8R9Rxpn1pwD727j6qy
         4/Wp9ng+NZrUiSL97bGojXNIukM8xqXTEe/xZ24tDD/Kv8gQ1JwukLYFETjdCEQyXq9i
         /azgDwlp4RE66uEl0EjFfwNzbdTp+kgBa86eoJjqbHUK+W+59h+vNEB5y23IELcICUeE
         GakA==
X-Forwarded-Encrypted: i=1; AFNElJ8gWSdNExSpYjtoJZla5kygWBn6cBBEoOKUolQq9duvncKOsRCsSxoUTuof1ReWDEB/O30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvwC7foRODOIqL8frt0rmeyPAXKK05b8AcbUXI/c9EhZM3wB/9
	NX5lNOHPqYEWCjZpLVI1ZkWkRCvxP83q4mGo93g2Q1J4bK5Tz80i+JRz
X-Gm-Gg: AeBDiet66nXU0qUFzwNchYacpbooyOvuhEmM09mOaHdOlFUBRGJwjlpSww+ZKjiM/cW
	obvkcKUInKUXG0fw8HfmGo08ICPFu4iuOuxNPS4nqMrkvaUy4NRF+kdOpxqy5KbJa8HvIhyo2Xb
	fg959SmWLhRLJIiKy+jFve05BnHGnq2Fzyt7NisSIvpM/NkegYPdwR4L1kT3DpVS/5JCSTl5Rqi
	xdrZuRBVsIk3zEUWFfgDU+P8W72pb7899H0drttXqdHozxoerQNeC3Z4yjGSv3oiqwMmmZV8GDX
	R2ExhAKdB6DGJ8FuUn/5dyq/MuERPC5CTi0XwcLYKqy7IvC69UkmWqTKSfYZkNP++rFy7QqyjyG
	cL/3r+iHHdi3hhU26KY8dWZf653fDlYjPnba4WBvwPP6jfvVmeqQKzzJsKjU8z+4FDY+EJ3dnq1
	ayYF12UNfYiNnrQFRUXlWiEjWNhH76nM4kGSLmvJoeRyaitFk=
X-Received: by 2002:a05:620a:258e:b0:8ee:3715:2127 with SMTP id af79cd13be357-904d63e7a0amr1428892785a.38.1778184760010;
        Thu, 07 May 2026 13:12:40 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:31::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd89sm2059382385a.35.2026.05.07.13.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:12:39 -0700 (PDT)
Date: Thu, 7 May 2026 13:12:35 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>, stefanha@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, horms@kernel.org, Yiqi Sun <sunyiqixm@gmail.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <afzyM6fTTAl0Hnvm@devvm29614.prn0.facebook.com>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
 <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>
 <afnXIGtswspSEk8x@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afnXIGtswspSEk8x@sgarzare-redhat>

On Tue, May 05, 2026 at 02:44:16PM +0200, Stefano Garzarella wrote:
> CCing Arseniy and Bobby.
> 
> On Tue, May 05, 2026 at 12:26:21PM +0200, Paolo Abeni wrote:
> > On 4/30/26 9:11 AM, Yiqi Sun wrote:
> > > vsockmon mirrors packets through virtio_transport_build_skb(), which
> > > builds a new skb and copies the payload into it. For non-linear skbs,
> > > this goes through virtio_transport_copy_nonlinear_skb().
> > > 
> > > Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
> > > As a result, skb_copy_datagram_iter() sees zero writable bytes
> > > in the destination iterator and copies no payload data.
> > > 
> > > This becomes an info leak because virtio_transport_build_skb() has
> > > already reserved payload_len bytes in the new skb with skb_put(). The
> > > skb is then returned to the tap path with that payload area still
> > > uninitialized, so userspace reading from a vsockmon device can observe
> > > heap contents and potentially kernel address.
> > > 
> > > Fix it by initializing iov_iter.count to the number of bytes to copy.
> > > 
> > > Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
> > > Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 416d533f493d..6b26ee57ccab 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
> > >  	iov_iter.nr_segs = 1;
> > > 
> > >  	to_copy = min_t(size_t, len, skb->len);
> > > -
> > > +	iov_iter.count = to_copy;
> > >  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
> > >  			       &iov_iter, to_copy);
> > 
> > @Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
> > pre-existing issue you should probably want to address:
> > 
> > >  	to_copy = min_t(size_t, len, skb->len);
> > Does this length calculation account for the offset when a packet is
> > split across multiple transmissions?
> > If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
> > but to_copy still evaluates to the full length of the skb.
> 
> Yep, I just checked and vhost-vsock is the only place where we call
> virtio_transport_deliver_tap_pkt() wiht an offset != 0, but I agree that we
> should also fix it.
> 
> Looking better in net/vmw_vsock/virtio_transport_common.c I think this is a
> regression, indeed we have this comment in virtio_transport_build_skb():
> 
> 	/* A packet could be split to fit the RX buffer, so we can retrieve
> 	 * the payload length from the header and the buffer pointer taking
> 	 * care of the offset in the original packet.
> 	 */
> 	pkt_hdr = virtio_vsock_hdr(pkt);
> 
> Before commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with
> sk_buff") we read the payload lenght from the header that is always set to
> the right value before delivering the packet to the tap.
> 
> From that commit, we don't to consider the offset anymore since we started
> to use `len` from the skb, so IMO we should go back to what we did before
> it, I mean:
> 
> 	payload_len = le32_to_cpu(pkt->hdr.len);
> 
> @Bobby do you remember why we did that change? Or if you see any issue going
> back to what we did initially?

I think this was just one that made it through the cracks. I vaguely
recall a few other instances where I assumed skb->len could stand-in for
hdr.len, but it didn't hold.

Using hdr.len like the original looks correct to me.

Best,
Bobby
