Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84768382F0F
	for <kvm@vger.kernel.org>; Tue,  3 Mar 2026 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573608; cv=none; b=bNDWTSGW1Cac2N6AEl/eXughzBA8eHVRDhNNVbHnuZY/uPTYsvAKiVy0/K1hIzNMwLh9W/L/iOrOYUYra7fj2zkffUxU0xCdgvAb70tJ76F09DWIq5Aw47Gf1TF4K6y166zc2lqWqkjZqpyxSwxEFXqWw+oiMY1g5S2mCZ2hy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573608; c=relaxed/simple;
	bh=8H4VMbX1c1Dw+bzL4MIuD9QMlbU7J38sY5x1T+pp/s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6CZqQTeU6uRDWeRNAPV4FBVsNpG9T56Wa5nSwUWqQjOcEEvZ7GdbJ8RPb3Ag0JSkm8LhGY4ANvwZOZhghLZLGBfRub5Rbmlt76uOKNq8bRVlXRrg37SqKkF+gMOs6jgfFiypwsKBc2URQoivs3d98r3FKB9F7rmjlMYADiPvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpjUokrI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZz1wM1B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpjUokrI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZz1wM1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772573606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jNRo3f93P8yVdU6vLNrgM8WIx5oFIjnqqxwGb/a0fwU=;
	b=IpjUokrI1Afhrf81RoHO9e93MNzYfb2J7uxejMKQ8kVeJrHomNy1bVECSBqRB54Cp3RYqB
	Lm+is0vrPhEao120UQ0LCwnlPeTjrLrsWBfu5NAEwvhoqDdZfzecKKWiRxmGJor1h6V6SG
	YutolCR5MGg1f7hx7y73mgimhYoyRow=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-GoF0xBVnP0WySAmbuD6UJQ-1; Tue, 03 Mar 2026 16:33:25 -0500
X-MC-Unique: GoF0xBVnP0WySAmbuD6UJQ-1
X-Mimecast-MFC-AGG-ID: GoF0xBVnP0WySAmbuD6UJQ_1772573605
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c881d0c617so3781692185a.1
        for <kvm@vger.kernel.org>; Tue, 03 Mar 2026 13:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772573605; x=1773178405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jNRo3f93P8yVdU6vLNrgM8WIx5oFIjnqqxwGb/a0fwU=;
        b=HZz1wM1BoVAnOZfJLHguHycsQUqUmkKf4jMc63CsN701i/68xbZ0iUvQBUNuYHFiMQ
         FHcBe1G38sSLRxOBUiwfsY+ykqXVDr9jAx7VnnjxpCcTSab1AWmL65s3aeK/jpbIiFMw
         tIYenlXKZY/pbLVvPle2rEqa8+O56eJZ6MF7/ghUg994IViuu/Af1vZawKx9f0PRaO5Z
         CmZD4MlOtCXT2F9mkvYrUcTNms4vBn427fZfTf/MWy+5gc4cyEEfWVFmiRbts9/6cVPf
         GIv41CBZMRVi1ebs83JymDN44VR6nkClAzvlu1zvo1ilLWliQF4w01WPYndOO1U9NL1l
         rO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772573605; x=1773178405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNRo3f93P8yVdU6vLNrgM8WIx5oFIjnqqxwGb/a0fwU=;
        b=nl5NVjw+LSG4gwm5haKy/OytU+OCswc9KW2F4B0Jt1SZiKrtxW8VTvkTx7OL48z+Qy
         m1eA4OR20/ntjRKaaVE0fgZXGsEvOuRsR+UPWr0hDvdY+hNN4P2CFsWrnKp4ZAd67YQD
         fHN3vi55H5ief7/C+mo0oOVu9Q407OXHpSgfKRMYIq1I7lC+KcJCiXVSZNOOQ4dgeP6E
         qJ8UvAxPsabIJr+9igkONd6JXk6z585ELG7537+7Jh4Sd8T5Yq7MBbiCdaXznnhE+fKC
         leXB0IiEJ6kD6gpFadaVo5q5E5++aEob55mCVlbFztG1KpQtlq3wg7beQCIrbDY7n6Si
         nqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiq/fze+i6zhen2OfxaZ5UoTOueWtw15YscAftxJEXE3NYnnevZxgtoZeA6cXVkfcy/2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8pUNQWjO366mfqjJdMKuyIIedx5Ysnvgy/1wfyqRdzi/gc98
	WFCEFj2jbzbeh71Yh/cgM4Dadh3E6Qf25S8fwWb4t9RGYs/kOoF35NnocKPfWK6GW85Nd2eSw9s
	YmXKV1NSpRvmWdXz0dexHSFvtSE7keJMfN6pbFHHWe69ZWqrQAF/sqA==
X-Gm-Gg: ATEYQzydLGAbnCsB3bZ0ufqLXZS8eDdVv8ZJTjRTNFK3TzxDkcv/wsHtnrUCtuo9qn3
	JLIYbEXz8Fu1CD5tU/Aou5YlD2yaknbuc2TJxQpwBe/1U+5/87P+5ZsHSeq8M1nPXrqE4ec7WVi
	ZJDJ/B3vLHKlEKFKXshMihLzw0Y+biNS7Qv0kiSIYwCKBdIc89Wr6NiYMmaq+XDX2muNSc7Nqbk
	wbv1MkdZLRGNeOkuhp4rMIwgmfAh/lN+fLLfDgRgTCDMy1KXLcQOo/9Pj5bdHUzlBg1/aXZ/dj9
	cSZ7JkRChxAOXEL7db+RURJKWZv0SagN5UH+FsBJbET/oHZmuxKbWWz8UQsGWzD5iThL4b3FLkU
	vhDM4VIrv42JnC4dntxTB+cHtyvozstYep9XKaEKqp5QGOGO4Cav+ylOSn1W1mI3pTtHlq9UUco
	0lD+b8zA==
X-Received: by 2002:a05:620a:1a21:b0:8c6:a539:55cd with SMTP id af79cd13be357-8cbc8df1ddcmr2128785985a.41.1772573605042;
        Tue, 03 Mar 2026 13:33:25 -0800 (PST)
X-Received: by 2002:a05:620a:1a21:b0:8c6:a539:55cd with SMTP id af79cd13be357-8cbc8df1ddcmr2128781985a.41.1772573604516;
        Tue, 03 Mar 2026 13:33:24 -0800 (PST)
Received: from x1.local (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf66c515sm1491514585a.11.2026.03.03.13.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:33:24 -0800 (PST)
Date: Tue, 3 Mar 2026 16:33:23 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 14/15] system/memory: add RamDiscardManager reference
 counting and cleanup
Message-ID: <aadTo2DNGIDv488m@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-15-marcandre.lureau@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-15-marcandre.lureau@redhat.com>

On Thu, Feb 26, 2026 at 02:59:59PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Listeners now hold a reference to the RamDiscardManager, ensuring it
> stays alive while listeners are registered. The RDM is eagerly freed
> when the last source and listener are removed, and also unreffed during
> MemoryRegion finalization as a safety net.
> 
> This completes the TODO left in the previous commit and prevents both
> use-after-free and memory leaks of the RamDiscardManager.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

