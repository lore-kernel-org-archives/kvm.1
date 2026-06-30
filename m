Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC9450911
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834752; cv=none; b=E/l/CyOPeDaY/HrWDYyKOlcV42gf5u0zP0iNAj6HWQEU3RORHroblWMHz8a2+p5iASO8g/PyL1vgyyza2yOAoV6N0mb/elluDwT2CKeVeOSOUFH8cBjhoUBB3cF7ObeuIDZ+elRu6XT32Pc715Ol0bVbdoebATBwskgw13f66Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834752; c=relaxed/simple;
	bh=xAV++Nv09s0Fx3qQqUFt2hh8zlLTaDft5mA4iivYxak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaY4pjXv4dxjXgbX9DZIjyazneEy4+ccIBzqKRpc5AnOgnHdXDKr2RhFlK7Ioc+gXEtfbndEbHZzr+IiExAdtIk1+hwLKAkz2Tj0QptXNoieAyE0Gatd9lMAvmfes7CHowuSJ3XnIMKpobATxrknYlRg/3Mz5+ILZ/svVqDl6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PnA90HKC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsncOWrg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnA90HKC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsncOWrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782834747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0U78ZlodXLMOImJ/ZNFyI40d4zG0e33pCvJOLPMpoNw=;
	b=PnA90HKCmV7n1HW8iG9iTgUjkfejpf0LMCghQoWd4VoUy/9c7BAnuVmDbcKy0JNj9xAwVe
	e0pM5ydpj81jdOQsZB36F4G/d6Iucz/H2ExqZMN8SaJO1/SfAhrXMTb+TYWPk/vP7wzje9
	MlETvitQr9v6sWF72vtiLKMJbPA4/dg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-xtGq142MMZq6gjCCD1g9CA-1; Tue, 30 Jun 2026 11:52:25 -0400
X-MC-Unique: xtGq142MMZq6gjCCD1g9CA-1
X-Mimecast-MFC-AGG-ID: xtGq142MMZq6gjCCD1g9CA_1782834744
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so7437255e9.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782834744; x=1783439544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0U78ZlodXLMOImJ/ZNFyI40d4zG0e33pCvJOLPMpoNw=;
        b=JsncOWrgiszwh2daQsPf6bfJWxQZDfziPSjV+dsM1F8Kqjk9OOVdP3fZOLvMLprcZz
         7VsuKiewE5UbmDr1kTA4v2Rq4+NFKj2QobAsCeJ2m1TglMHy3iUltQsVTGfc+Smh7Va3
         roMQ5OO3MsQOgn5AoJ5xNP64MLUfI551D4T2sA7YVN95cGvdLMs99bLbIQUpS7e3hQBz
         MIo34GB2/ch9WI1yK2BuIdx5Fd6pOuM8cKkNjeI1gTO9Vjo6g8kXOGnwqljtet4DHn9L
         FtyFaqIKwht5ffraNafMBKCxI9bmyddugtkykc2bRmi2+7YTrX7rqmq5/nZ4SFv6sbg8
         wcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834744; x=1783439544;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0U78ZlodXLMOImJ/ZNFyI40d4zG0e33pCvJOLPMpoNw=;
        b=rszIw0UMFTJ4fVfntWI4lU5o752o3j4BgodvQVJCEAU9XlsDlFXgl6nGulf3iQW2j9
         uN9sOld3sQYdNQYU0F+f42xaGropcjxsfeOEn05raLsMOjzwJDUCssxvQI/DZKd3wePK
         lBeqHHwNNExHIdGyy4WWE4EljniWW7wozRRURv3DETXlAElmWLTNFtcp+Ac7bCbVUfA8
         MlRV2nhuLlcSLcwt2pbyrl5XQgDQaz8YvPZ1mksxlFuGBdVPlNJq/htwr5HU9k6LP3Uw
         MN8rA4G87LNTtvwzu/9NOSpCERsQbSys2lZcVyFy18wb7k52cvKYqQrjKvozYdh/cP6z
         YKwA==
X-Gm-Message-State: AOJu0Yw/rG3qCVW+0iHn54ZqN7eYDBZSOsFQJ1e1HQe7vVjRFhIQ40FK
	tv4snH+GGtsVAfrRhY35kqYARYiu1Y+LCSdbVEp+gy0lNHS0XZ+CHZdL297pIeHHgnExOuWSFTD
	z3Biqci7vwdXH8KfGREphmj+WH3Dp/IZaa58PnkE0dls0Esq+ZvdvYQ==
X-Gm-Gg: AfdE7ckVNUU+CADxiQ8Qj/AWAbsloW4Vf9Y63H1Vr/NH8DWXMmnbooJX94MBhPnkv+J
	mkDQFQEgLJssZEqb52sQIy+UlOTB7JXzh53gE6D4L5UFReTEJTW+Qp0u+EOtjhacXG103GlrEmT
	P1094y2IolWANZVC+qeser1DKDhS+/MxJGICI8aV7zwqse0mpmp7Jy1lGVGNDh0iQa2uReVI1eq
	K/n8CIIAFUJoDLXdoYq3od/8276RPh1btJBGkKXaGGSckwVRby1uRXTaxzSvyFRnuV4+AtUnNSb
	FsW3dU93tuKCXEiMGjVft+dqy8nIBjBZxFSuBLLBGcvgDB8RNj1ZQ3sX82mui/qrwAZUkMgaKA6
	w0iAged6CNyJgHSM3tsSP18Gmly+3EwyAKVF9PqKaFLFWbJmz0forp3w7ALJgZYUF4bWV6eYJ6Y
	zRZ9d4ga6wig==
X-Received: by 2002:a05:600c:8715:b0:492:4871:7e21 with SMTP id 5b1f17b1804b1-493bc53dc56mr31413395e9.10.1782834744252;
        Tue, 30 Jun 2026 08:52:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8715:b0:492:4871:7e21 with SMTP id 5b1f17b1804b1-493bc53dc56mr31412855e9.10.1782834743805;
        Tue, 30 Jun 2026 08:52:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be22098esm5669225e9.2.2026.06.30.08.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:52:23 -0700 (PDT)
Message-ID: <caeaf483-b19d-45c8-82e1-79eb2d56dc65@redhat.com>
Date: Tue, 30 Jun 2026 17:52:21 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
To: Arseniy Krasnov <avkrasnov@rulkc.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
 rulkc@linuxtesting.org
References: <20260628182052.951760-1-avkrasnov@rulkc.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260628182052.951760-1-avkrasnov@rulkc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/26 8:20 PM, Arseniy Krasnov wrote:
> Logically it was based on TCP implementation, so to make further support
> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
> this way, patch also adds handling case when 'msg_ubuf' is already set.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>

The PW bot is on holiday, no automated notifications for a while.

Applied, thanks!

/P

