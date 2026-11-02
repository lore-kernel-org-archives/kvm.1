Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618864;
	b=G8mEcH1379a5UZo7Q+2s2G4j0hlp5KhWahrg9YCH8rNXm937QDlHFrZA/eZTZKakoQTg
	 73YNprvrYrf98anB8cFnavk62li+QK7EiP9m2zNAWell+YK7fB3Aqpr3SJvWjPlqUMMDH
	 6Pj6VX2h0ggAvjD5JQSRTsGOt2qLIqLe/ABtG5JoofRisrbDj4rENpLH6+j5BS7vkpk4p
	 5+kP0qbJZz9s1SNRonRf9riKfGvvL42mE+NARJjbFHSS2kDCVO9U6ujGTlTaCpYKNJCy9
	 JQhnKHNE5QgF58unUiq8S4bLLPCbYr+L3k3ZnfT1aoB3ljGj7mDeQ+Gg+szuC6hFwsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618864;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TEl1DgfXUA5pWV0ULqPFDtP6OTn2CRZgvQuqRoLVd2k=;
	b=1BiD+0YWOOWU+RSs0VdDELzIgBQuPu7HneK6AgXumBemwztUTiGOZYkQoUPE8hfve6or
	 eKDzGhgvmYPiPj93yGefshkUvVil7VFab3jm1f7v9AQe1LxMCJGt5pHXP84bkZ7ZMVJhn
	 MPpfyNY5/7dy8a4TfPopUxDh4nGezXwtPJeAvrlQCkeAXnYMuk1soEp4j6rEKIDpQ+Dw5
	 sl38k+9GfogvELMJ5xOQuOdZV0Ewle3RqmunkSXHk9Tdhcr1pybEr8NkkWWG/hDZyzj0K
	 lP1lEHBzxE2kfD0p0sc/0DjNMIZBhSurr87tBKre0WOTvEc/VYWjJ+wUfX5iaUd/1hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=UdlUnKwa;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710DE606A324;
	Mon,  2 Nov 2026 11:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 710DE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=UdlUnKwa
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xNqCJ-00BSF1-5z; Mon, 02 Nov 2026 12:27:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=TEl1DgfXUA5pWV0ULqPFDtP6OTn2CRZgvQuqRoLVd2k=; b=UdlUnKwa2wwdsv4p1NZcbSZeV7
	t4UOZnJaFeNb1oOLIegteX+/dZrJeyljqcQ8j+DemSAkcNZ9NA6RWxLB1qHZwZpB51BTC6BQllue7
	kUMdtmojCpnGTa7941e3k/nOmpzV90w9kZJo+S6M0WLvFJcPy3x0eW7Okn9UrI0Mho7XOqc1/gDPz
	J7OgLEcen16fXD3G+0uHsUVhj/SkBoJl+XumCZkg+45U3u6GRIH5EaDajhTqxh8WHW1GAr4INWy4d
	nUkOjpuLeOMmHg40TB5oRoTVszVeAuf/LQnMd7teaFJCfeGJI7wxfjhsnD0t6bOizG7rupdqMfw7W
	shLj9clg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xNqC6-0001gG-1k; Mon, 02 Nov 2026 12:27:18 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xNqC0-00BRqT-Uz;
	Mon, 02 Nov 2026 12:27:13 +0100
Message-ID: <44aa83c2-042b-4d4f-9f9c-f9be8b0fccc1@rbox.co>
Date: Mon, 2 Nov 2026 12:27:10 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next v4 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me,
 jlinbox@meta.com
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-4-047527cfccfc@meta.com>
 <atjZZP2ebhXKzMxL@sgarzare-redhat>
 <atld3+5LKmGxJ8+s@devvm29614.prn0.facebook.com>
 <atnjOZjKUBagRVWq@sgarzare-redhat>
 <d946003a-8bec-4e8b-89a3-05eeb96780cc@rbox.co>
 <auT+YIawHSMPHbJI@devvm29614.prn0.facebook.com>
 <5a411a67-f550-459d-be9b-5e8e51d3018c@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <5a411a67-f550-459d-be9b-5e8e51d3018c@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 02:21, Michal Luczaj wrote:
> On 10/30/26 21:30, Bobby Eshleman wrote:
>>> virtio_vsock_reset_sock() and vhost_vsock_reset_orphans() are my pet
>>> peeves: state switcheroo without taking lock_sock(). Which, again, races
>>> vsock_connect().
>>
>> True, I don't love that either, but I feel the impact is at least
>> constrained by the fact that it only happens when the module or device
>> is already going away.
> 
> Doesn't it happen on suspend as well? Is so, with a poorly timed connect()
> things can go south on resume.

What I wrote doesn't really make sense, does it? vsock_connect() cannot
freeze midway, so SS_UNCONNECTED (due to virtio_vsock_reset_sock() flipping
state to TCP_CLOSE) can't be set. Sorry.

But it is still the case for bind/unbind, right?
