Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C442CAFC
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508396; cv=none; b=tmIJHQsfBp0YXpLBtnnv+KD3doPqcSGKyV5FWmyrNra56z82fRbRr9Li6krq2s36f7MvcByLH+Nh7f4FJv89oo+GQHrBTwklHLh2bh9B8EEhjnAM2KnwCZkQGeguTy85nANYnxQDJlZpanVTr+z4jPOhQIVe1rkLj+PolZ7cT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508396; c=relaxed/simple;
	bh=Wxh1h5TWAdT1dv/JQYXllO6752pAMRojLLF30bzxwcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDHWcDoznf0L4Xt4a2oCHeK7cB3HlR6g+sByAbmn0l6cq60VIzilP8kn8eBateJokGK8gL7FvaWUL8+jgXQ6mHTuMs1Vb9YjhOtIMmC4u0Ni9yHSepWeCSt9AbOoi0h9OZXMZZNO8Ml6dCggaVLMHqf5gCti1ws/ABkwb+NeRyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBsSwO1A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U43iV86f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBsSwO1A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U43iV86f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783508387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6E0ixpEMrHT9a5crJiV6RHWP5trgVnT1h9yDneEUY78=;
	b=bBsSwO1AOLszaTUZrtKNIwihONR2zm2W0Zd3orA2EHnNV3/GHsbn9F6yKoTH03wp3BBrJ7
	cw5Rl0imIKngYldlDy8FcCJ1Sq2obR6iY9olcrKz96y2FtFsA4fKHtWJFmFKxx/ub61To7
	v2ct7AI37QINxyP35U6In1MPn+rhstA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-LfclywfzPemSdr8uxhKDiw-1; Wed, 08 Jul 2026 06:59:46 -0400
X-MC-Unique: LfclywfzPemSdr8uxhKDiw-1
X-Mimecast-MFC-AGG-ID: LfclywfzPemSdr8uxhKDiw_1783508385
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47dee73fdc7so882776f8f.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 03:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783508385; x=1784113185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6E0ixpEMrHT9a5crJiV6RHWP5trgVnT1h9yDneEUY78=;
        b=U43iV86fQCWGaoUI/WbpgRWUHK8p0DDASayl+U6HMl3tGqxvancJNoM0c599lEZw9L
         20rXFVd7Le8jtiCtOTnNoF2ec0xRqSep8iJM5MBAfHPsSVuD/vxEY291bip7esSQ80U3
         MRO/J9rVE8PwfMgvW1wvC0GIQ1Eucn+57cmgJ9wxkTO5aJ6eUcRm0TBZVNaaBtZi+hP2
         f50H7ZEqCXlnufZgQUeK67RWMPp1f8Q8zFJjdRu4Fumh88QjBpFzlWeLzbU16TL2r31N
         1VhKcCdBca0ciN0ndeoB+BoJTR1er/q7Oo3VPGfPOxEdDg7eiMZz7dqFU8YXlilHRLbQ
         HYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508385; x=1784113185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6E0ixpEMrHT9a5crJiV6RHWP5trgVnT1h9yDneEUY78=;
        b=tYj5dVMWOohIEU4ev7QCFDLaBipHiKKINlx1qTIy/4KkzrwhhXC4QfYTZJA9ahILlR
         R8vgB9OELc2y8FhE3IfBtGPnG/b/q7nJeFMv4AR+POSvp6DNd09H2IRnqUdDoMYLe+y1
         e1dfPayDo/13p+BmqAC5hd18sVxqn8+lBO/zw4FPX/CL6Yh9g7SvUiFXFwtecAi3MvjC
         ve3iZsdHDDFbmFMnFHp/EzOqnR/F1HdGVcdDftU55oSclVgSOkgkY8edfDY0VJLaUxeg
         bLhiZcdtqaQgWl64AgnN0uBO6SBnnMyB242jpDPO+kfmV7zrgyR8gPa3X5nQ20XkmUtb
         o3AQ==
X-Forwarded-Encrypted: i=1; AHgh+RrImOakZY/EUbliYf3vQ8UmoiZBgeSdzddMMDzOfrtzTh5WV4Su+hjmDOUnFFq6gtIhPZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhA7/u1zt7ZnO0RQC4JFylCF4CNFbnL0m3lZH0x8hzIwR4fpXT
	8c6JWWky8AX0DP51eZa2z/EdGomr7bZECd3D4W8HvXHCxsSA5OMl6eCQ1q+Aq/GrFjeBVvMWChZ
	0Oh3okZfhXG2aJSMVpCyqQhd0Qro2Vc/LH/EJCCyqGprjENKT2SlvGw==
X-Gm-Gg: AfdE7ck2bq4c8SmsZqLuyM0xEkqtl4gWxhlNpG+2PZohMbdQcOjXMuciDJLqPg/+oE5
	0tVc+/HTLTOsBMttLXgPIj2rQZTXF6UM5wpq4Y6G3oXO1l9ruTgrtGdJwN+E7YXAS8I9sgUEKRC
	MNpZ40m8HA5oW3aB5TP+ZOZzFY126jtZgFkkOVysDauOWwtL+00uUIoV0em3JEtCgjmMz3S6i5v
	G3xoy9WSONHTx0SlBQUU4rIYTLbGHLf7uSl6R2YMeMdTu2r68UHws3k4v77SvMuqo5oBOnKWQD0
	/jPe4g7abZhBUD6INYWdiq3ol80BXuaxjsnghxYAyErnUzru/DeT3k6u2VSuCmMwMoKZPQKE7wK
	tl1HrHpM3CE5s8H5EbzQm/SLyGvwe0wwB
X-Received: by 2002:a5d:5f42:0:b0:475:5e4b:588f with SMTP id ffacd0b85a97d-47df075a119mr2128511f8f.16.1783508385275;
        Wed, 08 Jul 2026 03:59:45 -0700 (PDT)
X-Received: by 2002:a5d:5f42:0:b0:475:5e4b:588f with SMTP id ffacd0b85a97d-47df075a119mr2128475f8f.16.1783508384801;
        Wed, 08 Jul 2026 03:59:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm43295235f8f.2.2026.07.08.03.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:59:44 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:59:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
Message-ID: <20260708065853-mutt-send-email-mst@kernel.org>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708102904.50732-3-sgarzare@redhat.com>

On Wed, Jul 08, 2026 at 12:29:04PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Add a test that sends 2 MB of data using randomly sized small packets
> (129-512 bytes) over a SOCK_STREAM connection. Packets above
> GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
> forcing each one into its own skb.
> 
> Without receive queue collapsing, the per-skb overhead eventually
> exceeds buf_alloc and the connection is reset. The test verifies
> that all data arrives and that content integrity is preserved.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

maybe cut down SO_VM_SOCKETS_BUFFER_SIZE? will make it easier to
trigger?

anyway

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tools/testing/vsock/vsock_test.c | 87 ++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 76be0e4a7f0e..b4ff9f946565 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -2347,6 +2347,88 @@ static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
>  	close(fd);
>  }
>  
> +/* Test that many small packets don't cause a connection reset under pressure
> + * and that data integrity is preserved.  Packet sizes vary randomly between
> + * 129 and 512 bytes, above GOOD_COPY_LEN (128) to bypass in-place coalescing
> + * in recv_enqueue, forcing each one into its own skb.  Without receive queue
> + * collapsing, the per-skb overhead eventually exceeds buf_alloc and the
> + * connection is reset.
> + */
> +#define COLLAPSE_PKT_MIN 129
> +#define COLLAPSE_PKT_MAX 512
> +#define COLLAPSE_TOTAL (2 * 1024 * 1024)
> +
> +static void test_stream_collapse_client(const struct test_opts *opts)
> +{
> +	unsigned char *data;
> +	unsigned long hash;
> +	size_t offset = 0;
> +	int i, fd;
> +
> +	data = malloc(COLLAPSE_TOTAL);
> +	if (!data) {
> +		perror("malloc");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	for (i = 0; i < COLLAPSE_TOTAL; i++)
> +		data[i] = rand() & 0xff;
> +
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> +	if (fd < 0) {
> +		perror("connect");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	while (offset < COLLAPSE_TOTAL) {
> +		size_t pkt_size = COLLAPSE_PKT_MIN +
> +			rand() % (COLLAPSE_PKT_MAX - COLLAPSE_PKT_MIN + 1);
> +
> +		pkt_size = min(pkt_size, COLLAPSE_TOTAL - offset);
> +
> +		send_buf(fd, data + offset, pkt_size, 0, pkt_size);
> +		offset += pkt_size;
> +	}
> +
> +	hash = hash_djb2(data, COLLAPSE_TOTAL);
> +	control_writeulong(hash);
> +
> +	free(data);
> +	close(fd);
> +}
> +
> +static void test_stream_collapse_server(const struct test_opts *opts)
> +{
> +	unsigned long hash, remote_hash;
> +	unsigned char *data;
> +	int fd;
> +
> +	data = malloc(COLLAPSE_TOTAL);
> +	if (!data) {
> +		perror("malloc");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
> +	if (fd < 0) {
> +		perror("accept");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	recv_buf(fd, data, COLLAPSE_TOTAL, 0, COLLAPSE_TOTAL);
> +
> +	hash = hash_djb2(data, COLLAPSE_TOTAL);
> +	remote_hash = control_readulong();
> +	if (hash != remote_hash) {
> +		fprintf(stderr, "hash mismatch: local %lu remote %lu\n",
> +			hash, remote_hash);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	free(data);
> +	close(fd);
> +}
> +
>  static struct test_case test_cases[] = {
>  	{
>  		.name = "SOCK_STREAM connection reset",
> @@ -2546,6 +2628,11 @@ static struct test_case test_cases[] = {
>  		.run_client = test_stream_msg_peek_client,
>  		.run_server = test_stream_peek_after_recv_server,
>  	},
> +	{
> +		.name = "SOCK_STREAM small packets backpressure",
> +		.run_client = test_stream_collapse_client,
> +		.run_server = test_stream_collapse_server,
> +	},
>  	{},
>  };
>  
> -- 
> 2.55.0

