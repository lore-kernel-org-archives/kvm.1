Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF021F12E0
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236148; cv=none; b=P4qa5xi+IS6m3P9PvZOrwtvVkRpO0ZZvV/rwYf6wqqMrIcf0GifBJ14Kjn7FVBB9HmNOcZDwWvR7ydeRa/bXR3GU7G8GOmdmkmEjZtSPA9Xfy+lpLfyKot1C/Y59FYY8jVU0F0btnWuQTlkanuH8VsTRTw8BHjJu81YVsHRrIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236148; c=relaxed/simple;
	bh=C7u8j+8ZuEu/hvPVjioug/5U81fzqILw0tnmGXAPFok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcGmEyFjKxbdJCwEJJlxC8xTUJSfOG6Jyw+jc9+IG9T/jFwplTwztpx8LNhZ48x/nKrvcEeG3LRyuze0sILcF8kCqy3El82sw31yssLPVMWmOS3MvDlIZ5xvtKqO+PnVjyem0sEq3Byd+j7y2iUZlydDdeF9aAGLroZKyNOP1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q32nrISy; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q32nrISy"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304d7f31215so3160301eec.1
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780236146; x=1780840946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgnkOucJ4lynEbyGWzUWoBKHmcQTYyOypcyzzzs1xrc=;
        b=q32nrISyCT5+jj6je2F2oKKGlrxZ3aQNWKhPT57SC9lZu4/VdS6TBZoJoScJmlvDcV
         2dwXBeCTKs98hfX1PQMqwxeLQqtlr4gILjte/dfXXWd4zYCtwmXh4zXtZgYqqJVHivgJ
         cDMW36fp8GvI2v5DqPbINlG/gRteYhzMFc3UIXGCypqpr7CJs3wMXhda/hx00kJXJHOX
         ZhwqzitMXA9EyIcl/G/B+5vQYrEZ1aJoonv1pQxrYfFg8cKM2WIXKbdBXHYpHxgtHwll
         /U14sYzDdsNv7Ildm0UmIZRG0vtSWa6MJ+xhPOsi/v4pgzmcNSkQRYz0tgOy7mnEZ2EC
         zmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780236146; x=1780840946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgnkOucJ4lynEbyGWzUWoBKHmcQTYyOypcyzzzs1xrc=;
        b=aDuqmUuKE8Vjg//HzXpBQ5J46/hKdf0LzID0XJYoC3Nrg51Af2KSuDUjyLRUY7BG8B
         2juBErdTcVMc+ki6Q0GIz5OlTC+v2FiMwfZ3Ih0zmY9524sHKb99G2DL8QdHW4A/kple
         j5a0K773tH0duwds4yI1aO/Hl9EVZRGwGWPqqyoEmr/lwa1qnxVAcxG4vDevjW4/p4Ax
         01AxTveRkuPwDC1SJRgZeSc1os6c2N4ECyi+bswGMQ7HTupS3kJDzTC7nZmocH8655X5
         CTOUJ6xr6jKkJ8h4akhL0nn/Awi7nVvpt8P9qDguTXn+1T45FCoY9Jcg+8GiqbqMzmwW
         ZUsA==
X-Forwarded-Encrypted: i=1; AFNElJ9cX198marVglDVocqPWwnNQo9Jx/kgTMsRLq6GpWErRdby9Y7H03N2F/gWHEjFYsQyuNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8dSAW2L7pHO/dlNp8y5KvL2A9GTGWoFvouzhEx6lNYxxJPX9
	YNbu2B8wm2/T0o9zzKLuYM8ajpsOHgKZd8sMxkGCzibpv2TyGNgj258f
X-Gm-Gg: Acq92OEKToNNJMV8Ejnz2p2EsCA0jTWq+5NIYlg34AZg1URkqybtNJ40Vj4yl+4UCZm
	1rHjhc+anH0FrWeymga9RuzfguSvsTg9y23B86ScnOS2yU0hUHH1m8vwcve0OP9qV8qsTT/TU1m
	AkKybnGMxYTLM8NwrA8sEav42wJfs9B3YF5KyCnv9UawqFy2yAWgQ4CB+RjasPeW5v7SeWBFkxs
	IHC0O3FonmU7yTZyoJLiidCwQ87fs/NaVLbH5CMCg5Cyd0syEmkQaXfIxwlP044J5AEHSYjnNJV
	LrKvBMDayLgw1NPWifLp5pTGYUhQuH+QZCAcg6MkT4DsSpPYyElTt82/bfgn+VnAWtNz9migvCZ
	LjrXmAhVx2TmDvLBpyRUO1pzZtRf/FP6kk0lsRi+Dg04QWXN3DpMzoz5OYfHJJzEgICc1WpHcfQ
	IsfZ0tG5Gnd+J8po/qE8Yoy5/m6+VP3ikjohPurlJbD+dnHehYkG4eW2UUyw==
X-Received: by 2002:a05:7300:3246:b0:304:6448:dfd7 with SMTP id 5a478bee46e88-304fa5e85demr3452313eec.18.1780236146056;
        Sun, 31 May 2026 07:02:26 -0700 (PDT)
Received: from [10.4.72.5] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53d14fsm6449412eec.17.2026.05.31.07.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 07:02:25 -0700 (PDT)
Message-ID: <10054db1-413b-42f7-b38f-f562b8de432f@gmail.com>
Date: Sun, 31 May 2026 22:02:19 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: Validate irqchip index for LoongArch and PowerPC
To: Sean Christopherson <seanjc@google.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, chenhuacai@kernel.org,
 maddy@linux.ibm.com, npiggin@gmail.com, sashiko-reviews@lists.linux.dev,
 pbonzini@redhat.com, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com,
 fangying.tommy@bytedance.com, Sashiko <sashiko-bot@kernel.org>
References: <20260525070154.495455-1-yanfei.xu@bytedance.com>
 <ahoYdrs9dVzp6Ps6@google.com>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <ahoYdrs9dVzp6Ps6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026/5/30 06:51, Sean Christopherson wrote:
> Can you split this into two patches, and send a v2?  I suspect the reason no one
> has picked this up is because it straddles two completely different (sub)subsystems.

That makes sense. Done :)

Thanks,
Yanfei

>
> That would also make it easier to get the fixes backported to stable trees.  PPC
> has been around a lot longer than LoongArch, so I assume the PPC fix will need to
> go further back in time.
>
> Thanks!
